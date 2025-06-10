addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})

async function handleRequest(request) {
  const url = new URL(request.url)

  // Forward all traffic to Azure Blob Static Website
  // currently we doing production
  url.hostname = 'stresumeprod.z5.web.core.windows.net' 

  const modifiedRequest = new Request(url.toString(), {
    method: request.method,
    headers: request.headers,
    body: request.body,
    redirect: 'follow'
  })

  // Blob storage expects this exact host header
  modifiedRequest.headers.set('Host', 'stresumeprod.z5.web.core.windows.net')

  return fetch(modifiedRequest)
}
