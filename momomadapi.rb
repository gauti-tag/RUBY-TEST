require 'typhoeus'
require 'json'


def transfers(debit_params)
  url = "http://preprod.ngser.com:5020/madapi/momo/transfers"

  request = Typhoeus::Request.new(
    url,
    method: :post,
    body: debit_params.to_json,
    headers: {

       'Content-Type'=> 'application/json',
       'Authorization' => "Bearer #{token}"

      }
       )
  request.run
  body = JSON.parse(request.response.body)
  body
end

def token
  token_url = "http://preprod.ngser.com:5020/madapi/auth"

  request = Typhoeus::Request.new(
    token_url,
    method: :post,
    body: credentials.to_json,
    headers: { 'Content-Type': 'application/json' }
  )
  request.run

  parsed_body = JSON.parse(request.response.body)
  parsed_body['token']
end

def credentials
  {
    client_id: "NGSER",
    client_secret: "b8911313-7a58-4fcd-b6c1-c1520c2097ee"
  }
end

def params
  {
    transaction_id: "57309687",
    amount: 100,
    msisdn: "245966601404",
    currency: "XOF",
    description: "transfert"
  }
end



#puts token

puts transfers(params)



