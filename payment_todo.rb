require "date"

class Todo
  def initialize(text, due_date, completed)
    @text = text #reason for payment
    @due_date = due_date #payment date
    @completed = completed #whether is paid or not
  end

  #check current obj due date is overdued
  def overdue?
    @due_date < Date.today
  end

  #check current obj due date is not expiry
  def due_later?
    @due_date > Date.today
  end

  #check current obj due date is today
  def due_today?
    @due_date == Date.today
  end

  #to display the value
  def to_displayable_string
    display_status = (@completed) ? "X" : " "
    display_date = (@due_date if @due_date != Date.today)
    "[#{display_status}] #{@text} #{display_date}"
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  #Find over dued today list
  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  #Find today payment today lists
  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end

  #Find later date today list
  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end

  #Add new todo list
  def add(todo)
    @todos.push(todo)
  end

  #get each element and send to the to_displayable_string method in Todo class
  #return the array of string
  def to_displayable_list
    @todos.map { |todo| todo.to_displayable_string }.join("\n")
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
