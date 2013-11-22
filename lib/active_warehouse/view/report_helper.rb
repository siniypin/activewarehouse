# Helper module for rendering reports.
require 'builder'
module ReportHelper
  # include ActiveWarehouse::Report::YuiAdapter

  # UNSUPPORTED METHOD. Please use render_report_from instead.
  # * <tt>report</tt>: The report instance
  # * <tt>html_options</tt>: HTML options
  def render_report(report, html_options={})
    raise "Unsupported Render Method.  Please use render_report_from instead."
  end

  def render_report_json(table_view)
    JsonReportFormatter.new.render_report(table_view)
  end

  def render_report_csv(table_view)
    CsvReportFormatter.new.render_report(table_view)
  end

  def render_report_from(table_view, html_options = {})
    HtmlReportFormatter.new.render_report(table_view, html_options)
  end

  def render_crumbs(crumbs)
    breadcrumb_html = []
    return if crumbs.size == 1

    crumbs.each do |crumb|
      if crumb != crumbs.last
        breadcrumb_html << link_to(crumb.link_to_name, crumb.link_to_params)
      else
        breadcrumb_html << crumb.link_to_name
      end
    end
    result = breadcrumb_html.join(' &#187; ')
    result.blank? ? "" : "#{crumbs.last.crumb_type}: #{result}"
  end

  def render_chart_report(table_view, chart_id = "yui_chart")
    Yui4Rails::Widgets::Chart.new(:bar, chart_id,
                                  {
                                      :data_rows => yui_data_rows(table_view),
                                      :col_defs => yui_column_definitions(table_view),
                                      :series_defs => yui_series_definitions(table_view),
                                      :y_field => "row_dimension_label"
                                  }).render
  end
end