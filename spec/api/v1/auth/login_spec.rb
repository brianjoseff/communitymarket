require 'spec_helper'

describe :login do
  let(:params) {{}}
  let(:before_api_call) {}
  before { before_api_call }
  before { post "api/v1/users/login", Hash[params].to_json,{"CONTENT_TYPE" => "application/json"}}

  describe "Logging in with an email address" do
    context "With all required params" do
      let(:params) {{email:email, password:password}}

      context "With a valid email and password" do
        let(:email) {"borys216307@outlook.com"}
        let(:password) {"hello123456"}

        it {expect(response.status).to eq 200}
        it {expect(response.headers["Content-Type"]).to eq "application/json"}
        it {expect(JSON.parse(response.body)).to_not be_nil}
        it {expect(JSON.parse(response.body)[auth_token]).to_not be_nil}
      end
    end
  end

end
