- dashboard: jins
  title: jins
  layout: newspaper
  elements:
  - name: this is merged result
    title: this is merged result
    merged_queries:
    - model: rie_test
      explore: order_items
      type: table
      fields: [inventory_items.id, products.brand, products.avg]
      filters:
        inventory_items.id: "<100"
      sorts: [inventory_items.id]
      limit: 500
      query_timezone: America/Toronto
      hidden_fields: []
      y_axes: []
    - model: david_snowflake_ecom
      explore: inventory_items
      type: table
      fields: [inventory_items.id, distribution_centers.name]
      limit: 500
      query_timezone: America/Toronto
      hidden_fields: []
      y_axes: []
      join_fields:
      - field_name: inventory_items.id
        source_field_name: inventory_items.id
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    size_to_fit: true
    series_column_widths:
      products.brand: 150
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [products.avg]
    type: looker_grid
    y_axes: []
    pivots: [products.brand]
    dynamic_fields: [{table_calculation: calculation_1, label: Calculation 1, expression: "${products.avg}*100",
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    row: 0
    col: 0
    width: 16
    height: 6
  - title: New Tile
    name: New Tile
    model: rie_test
    explore: order_items
    type: table
    fields: [orders.count, orders.status]
    sorts: [orders.count desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    note_state: collapsed
    note_display: below
    note_text: this is not merged result
    listen: {}
    row: 0
    col: 16
    width: 8
    height: 6
