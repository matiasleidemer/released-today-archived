module Repositories
  class NotificationRepository
    attr_reader :model

    delegate_missing_to :@model

    def initialize(model = Notification)
      @model = model
    end
  end
end
