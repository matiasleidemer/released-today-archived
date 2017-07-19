module Released
  class Jwt
    attr_reader :client, :global_token

    def initialize(client: JWT, global_token: Rails.application.secrets.jwt_global_token)
      @client = client
      @global_token = global_token
    end

    def self.encode(payload)
      new.encode(payload)
    end

    def self.decode(payload)
      new.decode(payload)
    end

    def encode(payload)
      client.encode(payload, global_token)
    end

    def decode(payload)
      client.decode(payload, global_token)
    end
  end
end
