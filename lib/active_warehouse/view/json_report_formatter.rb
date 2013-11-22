class JsonReportFormatter
  def render_report table_view, options = {}
    column_dimension = table_view.column_dimension
    row_dimension = table_view.row_dimension

    report_fields = [] << row_dimension.hierarchy_level_label
    column_dimension.values.each do |col_dim_value|
      report_fields << col_dim_value
    end

    result = []

    table_view.data_rows.each do |data_row|
      result_row = {}

      result_row[report_fields.first]= data_row.dimension_value

      unless data_row.cells.collect { |c| c.raw_value }.reduce(:+) == 0
        data_row.cells.each_with_index do |cell, index| # aggregated facts
          result_row[report_fields[index+1]]= cell.value
        end

        result << result_row
      end
    end

    result
  end
end