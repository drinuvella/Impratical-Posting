import { createClient } from 'supabase';
import { JWT } from 'google-auth-library';

interface WebhookPayload{
  type:'UPDATE'
  table:string
  record: QuestionAnswer
  schema: 'public'
  old_record: QuestionAnswer
}

const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
)

Deno.serve(async (req) => {
  const payload: WebhookPayload = await req.json()

  const {default: {serviceAccount}} = await import('../service-account.json',{
    with: {type: 'json'},
  })

  const accessToken = await getAccessToken({clientEmail: serviceAccount.clientEmail,privateKey: serviceAccount.privateKey})

  const res = await fetch('https://fcm.googleapis.com/fcm/send', 
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `BEARER ${accessToken}`,
      },
      body: JSON.stringify({
        to:'/topics/all',
        message:{
          notification: {
            title: 'Impratical posting',
            body: `Someone sent a new answer/ question`,
          },
        }
      })
    })

  const resData = await res.json()
  return new Response(
    JSON.stringify(data),
    { headers: { "Content-Type": "application/json" } 
  })
})

const getAccessToken = ({
  clientEmail,
  privateKey,
}:{clientEmail:string, 
  privateKey:string
}
): Promise<string> => {
  return new Promise((resolve, reject) => {
    const jwtClient = new JWT({
      email: clientEmail,
      key: privateKey,
      scopes:['https://www.googleapis.com/aut/firebase.messaging']
    })
    jwtClient.authorize((err, tokens)=>{
      if(err){
        reject(err)
        return;
      }
      resolve(tokens!.accessToken!)
    })
  })
}