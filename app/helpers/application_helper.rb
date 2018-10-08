module ApplicationHelper
  include ActionView::Helpers::TagHelper

  def div(element_name, &block)
    tag.div class: element_name, id: element_name, &block
  end

  def row(&block)
    tag.div class: 'row', &block
    # tag.send(:div,class: 'row', &block)
  end

  def panel(&block)
    tag.div class: 'panel panel-default', &block
  end

  def panel_heading(&block)
    tag.div class: 'panel-heading', &block
  end

  def panel_body(&block)
    tag.div class: 'panel-body', &block
  end

  def column2(&block)
    tag.div class: 'col-xs-12 col-sm-2', &block
  end

  def column3(&block)
    tag.div class: 'col-xs-12 col-sm-3', &block
  end

  def column4(&block)
    tag.div class: 'col-xs-12 col-sm-4', &block
  end

  def column_half(&block)
    tag.div class: 'col-xs-12 col-sm-6', &block
  end

  def column8(&block)
    tag.div class: 'col-xs-12 col-sm-8', &block
  end

  def column10(&block)
    tag.div class: 'col-xs-12 col-sm-10', &block
  end

  def column(&block)
    tag.div class: 'col-xs-12', &block
  end

  def contact_support(msg = '')
    Rails.logger.error(msg)
    "#{msg} Contact Jeweler Support if the problem persists."
  end

  def self.name_pretty(pretty_name)
    pretty_name.titleize
  end

  def self.name_pretty2(pretty_name)
    pretty_name.gsub! '_', ' '
    pretty_name.capitalize!
    pretty_name
  end

  def self.uglify(ugly_name)
    ugly_name.gsub! ' ', '_'
    ugly_name.downcase
    ugly_name
  end

  def self.note_event_action(note)
    case note.note_type
    when 'commit'
      'Committed Code'
    when 'event'
      case note.event_type
      when 'task_created'
        'Created a Task'
      when 'task_updated'
        'Updated a Task'
      when 'task_deleted'
        'Deleted a Task'
      when 'sprint_opened'
        'Opened a Sprint'
      when 'sprint_closed'
        'Closed a Sprint'
      when 'hours_reported'
        'Reported Hours'
      when 'task_completed'
        'Completed a Task'
      when 'sprint_completed'
        'Completed a Sprint'
      when 'payment_request_cancelled'
        'Cancelled a Payment Request'
      when 'current_task_changed'
        'Changed Current Task'
      when 'current_sprint_changed'
        'Changed the Current Sprint'
      else
        ''
      end
    when 'project_update'
      'Posted a Project Update'
    when 'payment_request'
      'Requested a Payment'
    when 'payment'
      'Made a Payment'
    when 'note'
      'Posted a Note'
    when 'demo'
      'Posted a Demo of ' + note.content
    else
      ''
    end
  end

  def self.note_icon_header_section(note_type)
    case note_type
    when 'project_update'
      '<div class="cbp_tmicon timeline-bg-warning">
                  <i class="far fa-clock"></i>
                </div>'
    when 'event'
      '<div class="cbp_tmicon timeline-bg-info">
              <i class="far fa-clock"></i>
            </div>'
    when 'note'
      '<div class="cbp_tmicon timeline-bg-success">
                  <i class="fas fa-sticky-note"></i>
                </div>'
    when 'demo'
      '<div class="cbp_tmicon timeline-bg-red">
                  <i class="fa-binoculars"></i>
                </div>'
    when 'payment'
      ' <div class="cbp_tmicon timeline-bg-success">
                  <i class="fas fa-dollar-sign"></i>
                </div>'
    when 'payment_request'
      '<div class="cbp_tmicon timeline-bg-success">
                  <i style="color:white !important" class="fas fa-hand-holding-usd white-icon"></i>
                </div>'
    when 'commit'
      '<div class="cbp_tmicon timeline-bg-danger">
                  <i class="fas fa-code-branch"></i>
                </div>'
    else
      '<div class="cbp_tmicon timeline-bg-success">
                  <i class="fas fa-sticky-note"></i>
                </div>'
    end
  end

  def self.note_icon_color(note_type)
    case note_type
    when 'project_update'
      'warning'
    when 'event'
      'info'
    when 'note'
      'success'
    when 'demo'
      'danger'
    when 'payment'
      'success'
    when 'payment_request'
      'success'
    when 'commit'
      'danger'
    else
      'success'
    end
  end

  def self.note_icon(note_type)
    case note_type
    when 'project_update'
      '<i class="far fa-clock"></i>'
    when 'event'
      '<i class="far fa-clock"></i>'
    when 'note'
      '<i class="fas fa-sticky-note"></i>'
    when 'demo'
      '<i class="fa-binoculars"></i>'
    when 'payment'
      '<i class="fas fa-dollar-sign"></i>'
    when 'payment_request'
      '<i style="color:white !important" class="fas fa-hand-holding-usd white-icon"></i>'
    when 'commit'
      '<i class="fas fa-code-branch"></i>'
    else
      '<i class="fas fa-sticky-note"></i>'
    end

  end

  def self.sprint_percent(project)
    return 0 if project.current_sprint.nil?
    total_tasks = project.current_sprint.tasks.count
    completed_tasks = project.current_sprint.tasks.completed_tasks.count
    tasks_diff = if total_tasks > 0
                   completed_tasks.to_f / total_tasks.to_f
                 else
                   0
                 end
    progress_total = (project.sprint_current - 1.0) + tasks_diff.to_f
    progress_percent = (progress_total.to_f / project.sprint_total.to_f) * 100.to_f
    progress_percent
  end

  def self.alphabet
    ('a'..'zz').to_a
  end

  def self.display_project_nav?(project, controller_name, action_name)
    return false if !defined? project || project.nil?
    project_child = (controller_name.split('_').first == 'project')
    case controller_name
    when 'projects' then return true if %w[show edit settings users].include?(action_name)
    when 'sprints' then return true
    when 'payments' then return true if action_name == 'index'
    when project_child then return true
    end
    false
  end

end
