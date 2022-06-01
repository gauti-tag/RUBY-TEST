require 'jwt'

payload = {data: 'test', password: '14789563'}

token = JWT.encode payload, nil, 'none'

decode_token = JWT.decode token, nil, false


#puts token
puts decode_token