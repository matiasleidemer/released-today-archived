RSpec.shared_examples "Profile API" do |verb, endpoint|
  it "returns unauthorized if user token is invalid" do
    send(verb, endpoint, headers: { "X-Released-User-Token" => "nope" })

    expect(response.status).to eq(401)
    expect(response.body).to eq("Bad credentials")
  end
end
