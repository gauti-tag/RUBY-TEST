
require 'typhoeus'
require 'json'
require 'securerandom'
require "base64"
require "ostruct"

# get access_token
#
TOKEN = "NzM5MjllNGUtMjI3OS00M2IwLTlkYjktNTMwMDk2Mzg3ZjM1OjBkNGQ3ZGY0NzEzNTQ0NDE4ODk3MGQzZTI4ZjA2ZTgy"
SUBSCRIPTION_KEY = "4d085feaf0764cc2a3f4b1261ee1b533"
SUBSCRIPTION_KEY_DISBURSEMENT = "8efced20835c4043aa97be72159ec257"
TOKEN_DISBURSEMENT = "ZDZlZTdjZmItNGU3YS00ZjVmLWE3M2EtMDM2MzU2YmFlMjdkOjJkNDE5ODI4OGUyNDQyMWM5NzcxZWIyMDVhMzgyYmU5"


#Payment
def requesttopay(data)
  url = "https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay"
  #uuid = SecureRandom.uuid
  request = Typhoeus::Request.new(
    url,
    method: :post,
    body: data.to_json,
    headers: {
      "Authorization" => "Bearer #{token}",
      #"X-Callback-Url" => "https://pay-money.net/",
      "X-Reference-Id" => "#{SecureRandom.uuid}",
      "X-Target-Environment" => "sandbox",
      "Content-Type" => "application/json",
      "Ocp-Apim-Subscription-Key" => SUBSCRIPTION_KEY
    }
  )

  request.run
  request.response.code
=begin
  request.on_complete do |response|

    if response.success?
      code = request.response.code
      case code
      when 202
       code  #OpenStruct.new(code: 200, message: "Accepted")
      when 400
       code #OpenStruct.new(code: 400, message: "Failed")
      when 409
       code #OpenStruct.new(code: 409, message: "Conflict")
      else
       code #OpenStruct.new(code: 400, message: "Accepted")
      end
    else
      OpenStruct.new(code: 400, message: "Failed")
    end
  end
  request.run
=end
end

#Check Payment status
def requesttopaycheckstatus(param) 
  url = "https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay"

  request = Typhoeus::Request.new(
    url,
    method: :get,
    params: param,
    headers: {
      "Authorization" => "Bearer #{token}",
      "X-Target-Environment" => "sandbox",
      "Ocp-Apim-Subscription-Key" => SUBSCRIPTION_KEY
    }
  )

  request.run
  JSON.parse(request.response.body)
end

#Generate token
def token
  url = "https://sandbox.momodeveloper.mtn.com/collection/token/"
  request = Typhoeus::Request.new(
    url,
    method: :post,
    body: "",
    headers: {
      'Authorization' => "Basic #{ENV['TOKEN']}",
      'Ocp-Apim-Subscription-Key' => SUBSCRIPTION_KEY
    }
  )

  request.run
  JSON.parse(request.response.body)['access_token']

end

def disbursement_token
  url = "https://sandbox.momodeveloper.mtn.com/disbursement/token/"

  request = Typhoeus::Request.new(
    url,
    method: :post,
    body: "",
    headers: {
      'Authorization' => "Basic #{TOKEN_DISBURSEMENT}",
      'Ocp-Apim-Subscription-Key' => SUBSCRIPTION_KEY_DISBURSEMENT
    }
  )

    request.run
    JSON.parse(request.response.body)
end

#Payment params
def payment_params
  {
      amount: "100",
      currency: "EUR",  #EUR is for test
      externalId: "#{SecureRandom.uuid}",
      payer: {
        partyIdType: "MSISDN",
        partyId: "22555470373"   #0554869299 / 0555470373
      },
      payerMessage: "Paymoney forever!",
      payeeNote: "Test Ngser"
  }
end

def reference_id_param
  {
    referenceId: "ac0e85d8-4f38-4ecf-b377-7e064aa5a4d4" #ac0e85d8-4f38-4ecf-b377-7e064aa5a4d4 / f5eb5c58-3d82-44ce-8f1d-e1c6dcc84654
  }
end

def payment_body_params(msisdn, token_transaction, amount, reference_id)

  params_body = {}
  params_body[:amount] = amount.to_i
  params_body[:currency] = "EUR"
  params_body[:externalId] = token_transaction
  params_body[:partyId] = msisdn
  params_body[:referenceId] = reference_id

  return params_body
end

def payment_body_params_test(msisdn, token_transaction, amount, reference_id)
  {
    amount: amount,
    currency: "EUR",
    externalId: token_transaction,
    partyId: msisdn,
    referneceId: reference_id
  }
end

a = "73929e4e-2279-43b0-9db9-530096387f35"
b = "0d4d7df47135444188970d3e28f06e82"
#Test for base 64
#enc_distursement = Base64.encode64('d6ee7cfb-4e7a-4f5f-a73a-036356bae27d:2d4198288e24421c9771eb205a382be9')
enc_pay = Base64.encode64("#{a}:#{b}")
puts enc_pay
#puts enc_distursement
#plain = Base64.decode64(enc)
#puts enc
#puts plain
#puts token

#p requesttopay(payment_params)
#b = SecureRandom.uuid   # Valid one for transfet request : def48c22-cd52-445d-9075-64a186916039
#puts b

#p disbursement_token

#p payment_body_params("0502321458","147852369", "1000", "147djjdjd2485d")

#p payment_body_params_test("0502321458","147852369", "1000", "147djjdjd2485d")


