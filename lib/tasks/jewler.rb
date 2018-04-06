namespace :Jewler do

  desc 'Switch all hours to planned_hours for invoice_items'
  task :convert_hours do
    puts 'Starting Hour Conversion Script'

    InvoiceItem.all.each do |task|

      unless task.hours.nil?
        if task.hours == 0.0
          task.hours = nil
          puts "Task 0.0 Hours set to Nil ID: " + task.id.to_s
        else
          task.planned_hours = task.hours
          task.hours = nil
          puts "Task Planned Hours Converted To Hours ID: " + task.id.to_s
        end
      end

      if task.planned_hours = 0.0
        task.planned_hours = nil
        puts "Planned hours were 0.0, changed to nul"
      end

      task.save
    end

  end

end
