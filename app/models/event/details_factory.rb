module Event
  class DetailsFactory
    attr_reader :event

    def initialize(event)
      @event = event.eventable
      send(event.subject.to_sym)
    end

    def invitation_deleted
      "#{event.email} invitation was deleted."
    end

    def invitation_accepted
      "#{event.email} accepted Project invitation."
    end

    def invitation_declined
      "#{event.email} declined Project invitation"
    end

    def payment_made
      "$ #{event.payment_amount} payment for Sprint #{eventable.sprint.sprint} by #{event.user.full_name}"
    end

    def invitation_sent
      "#{event.email} was sent an invitation to join the project as a #{event.user_type}"
    end

    def payment_requested
      "Sprint #{event.sprint.sprint} payment requested"
    end

  end
end