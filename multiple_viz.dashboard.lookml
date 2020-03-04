- dashboard: multiple_viz
  title: Multiple viz
  layout: newspaper
  elements:
  - name: multiple viz
    title: multiple viz
    model: rie_test
    explore: order_items
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [order_items.count, order_items.agg_test]
    limit: 500
    query_timezone: America/Toronto
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 0
    series_types: {}
    row: 0
    col: 0
    width: 8
    height: 6
