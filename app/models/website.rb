require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'data/db.sqlite3', pool: 10)

class Website < ActiveRecord::Base
  validates_presence_of :token
end

unless ActiveRecord::Base.connection.table_exists?(:websites)
  ActiveRecord::Migration.class_eval do
    create_table :websites do |t|
      t.string :token, null: false, index: true
      t.boolean :is_spa, null: false, default: false

      t.timestamps
    end
  end
end
