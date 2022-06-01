require 'typhoeus'
require 'json'



def payout(deposit_params)
  deposit_url = "http://crossroadtest.net:5020/madapi/momo/transfers"

  request = Typhoeus::Request.new(
    deposit_url,
    method: :post,
    body: deposit_params.to_json,
    headers: {
      'Content-Type': 'application/json',
      'Authorization' => "Bearer #{token}"
    }
  )

  request.run
  #response = request.response.body
  #response
  #data = JSON.parse(response)
  if request.on_complete && JSON.parse(request.response.body)['statusCode'] == 200
    OpenStruct.new(status: 200, data: JSON.parse(request.response.body))
    #@message = "oui"
  else
    #@message = "non"
    OpenStruct.new(status: 400, message: "Request Failed", data: JSON.parse(request.response.body))
  end

end
 def payout_preprod(deposit_params)
  deposit_url = "http://preprod.ngser.com:5020/madapi/momo/transfers"

  request = Typhoeus::Request.new(
    deposit_url,
    method: :post,
    body: deposit_params.to_json,
    headers: {
      'Content-Type': 'application/json',
      'Authorization' => "Bearer #{token_preprod}"
    }
  )

  request.run
  #response = request.response.body
  #response
  #data = JSON.parse(response)
  if request.on_complete && JSON.parse(request.response.body)['statusCode'] == 200
    OpenStruct.new(status: 200, data: JSON.parse(request.response.body))
    #@message = "oui"
  else
    #@message = "non"
    OpenStruct.new(status: 400, message: "Request Failed", data: JSON.parse(request.response.body))
  end
 end


 def sms_preprod(sms_params)
  url = "http://preprod.ngser.com:5020/madapi/push/sms"

  request = Typhoeus::Request.new(
    url,
    method: :post,
    body: sms_params.to_json,
    headers: {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{token_preprod}"
    }
  )

  request.run
  body = JSON.parse(request.response.body)
  body

 end

def debit(debit_params)
  url = "http://crossroadtest.net:5020/madapi/momo/debits"

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
  body['statusCode']
end

def token
  token_url = "http://crossroadtest.net:5020/madapi/auth"

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

def token_preprod
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

def sms 
  {
    msisdn: "245966601404",
    body: "TEST"
  }
end

def params
  {
    transaction_id: "17209687",
    amount: 200,
    msisdn: "245966601404",
    currency: "XOF",
    description: "transfert"
  }
end




#puts token
#puts token_preprod
#p  payout(params)
#puts payout_preprod(params)
puts sms_preprod(sms)

#p debit(params)
