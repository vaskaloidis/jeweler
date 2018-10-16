# frozen_string_literal: true

class EventType
  NOTE = %i[owner_note developer_note customer_note project_update_note].freeze
  PROJECT = %i[].freeze
  COMMIT = %i[push].freeze
  PAYMENT = %i[payment_made].freeze
  SPRINT = %i[sprint_opened sprint_closed sprint_completed payment_requested payment_request_cancelled].freeze
  TASK = %i[task_created task_updated task_deleted task_completed hours_reported planned_hours_reported current_task_changed].freeze
  INVITATION = %i[invitation_sent invitation_deleted invitation_accepted invitation_declined].freeze
end