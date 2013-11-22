require 'csv'

class CsvReportFormatter
  def render_report(table_view, options = {})
    CSV.generate(options) do |csv|
      column_dimension = table_view.column_dimension
      row_dimension = table_view.row_dimension

      csv << row_dimension.hierarchy_level_label
      column_dimension.values.each do |col_dim_value|
        csv << col_dim_value
      end

      table_view.data_rows.each do |data_row|
        result_row = []

        result_row << data_row.dimension_value

        unless data_row.cells.collect { |c| c.raw_value }.reduce(:+) == 0
          data_row.cells.each_with_index do |cell, index| # aggregated facts
            result_row << cell.value
          end

          csv << result_row
        end
      end
    end
  end
end