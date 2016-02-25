class Todolist < ActiveRecord::Base

  def create_todoitemrecord (name,description)
    item = Todolist.new
    item.name = name
    item.description = description
    item.status = false
    item.save
  end

  def self.list_all
    Todolist.all
  end

  def change_status(item)
    item.status = true
    item.save
  end
end
