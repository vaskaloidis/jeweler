module Task
  class CreateTask < Jeweler::ServiceObject
    def initialize(task_params)
      @task = Task.new(task_params)
    end

    def call
      @sprint = Sprint.find(@task.sprint.id)
      @current_sprint = @sprint.project.sprint_current

      @task.position = @task.sprint.next_position_int

      respond_to do |format|
        if @task.save

          # Set Current @task if none, and is first Sprint @task created
          if @task.sprint.tasks.empty? && @task.sprint.project.current_task.nil? && @task.sprint.current?
            project = @task.sprint.project
            project.current_task = @task
            project.save
            if project.invalid?
              @errors << 'Error setting new current-task'
              project.errors.full_messages.log_errors('TasksController - Error changing current-Task')
            end
            @task.sprint.project.reload
          end

          if @task.valid?
            @success = true
            Note.create_event(@sprint.project, 'task_created', 'Task Created: ' + @task.description)
          else
            @success = false
            @task.errors.full_messages.map { |e| @errors << 'Error Creating @task: ' + e }
          end
          format.js
          format.json { render :show, status: :created, location: @task }
        else
          @success = false
          @task.errors.full_messages.map { |e| @errors << 'Error Creating @task: ' + e }
          format.js
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end

      @task
    end

    private

    attr_reader :task
  end
end