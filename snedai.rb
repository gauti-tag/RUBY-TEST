require 'typhoeus'
require 'json'

# We use params to the request
def rdv(parameters)

  url = "https://dml_togo.appinov.net/digipass/ws/v2/"

  request = Typhoeus::Request.new(
    url,
    method: :get,
    params: parameters,
    ssl_verifypeer: false,
    followlocation: true
  )

  request.run
  #JSON.parse(request.response.body, symbolize_names: true)
   JSON.parse(request.response.body) #['data']
  #party['data']
end

def query_params
{
  methode: "prise_rdv",
  id: "0013A",
  id_tranche: "6",
  email: "marcel.bessin@gmail.com",
  nom: "BESSIN",
  adresse: "AMBASSADE DE COTE D'IVOIRE A PARIS",
  prenoms: "CYNTHIA",
  tel: "2250709620181",
  date_rdv: "2022-05-24",
  statut: "RESERVED"
}
end

def tata
  {
    methode: 'prise_rdv',
    id: params[:transaction_id],
    id_tranche: params[:time_code],
    email: params[:email],
    nom: params[:lastname],
    adresse: params[:address],
    prenoms: params[:firstname],
    tel: params[:phone_number],
    date_rdv: params[:meeting_date],
    statut: "RESERVED"
  }
end

a = rdv(query_params)

puts a



