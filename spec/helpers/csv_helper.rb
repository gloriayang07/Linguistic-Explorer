module CSVHelper

  def generate_csv(*models)
    base = models.first.class

    CSV.open("spec/csv/#{base.name}.csv", "wb") do |csv|
      # header row
      cols = base::IMPORT_ATTRIBUTES
      csv << cols

      # data rows
      models.each do |model|
        csv << cols.map { |attribute| model.send(attribute) }
      end
    end

  end
  
  def csv_row_count_should_equal_count_of(*models)
    # Add one to account for header row
    CSV.read("spec/csv/#{models.first.class.name}.csv").size.should == models.size + 1
  end

end