addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})

async function handleRequest(request) {
  const url = new URL(request.url)
  url.hostname = "${origin_hostname}"

  const modifiedRequest = new Request(url.toString(), {
    method: request.method,
    headers: request.headers,
    body: request.body,
    redirect: 'follow'
  })

  modifiedRequest.headers.set('Host', "${origin_hostname}")

  return fetch(modifiedRequest)
}
