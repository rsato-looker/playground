- dashboard: bugrepro281721
  title: BugRepro281721
  layout: newspaper
  elements:
  - title: TwoPivotedColumns
    name: TwoPivotedColumns
    model: rie_test
    explore: order_items
    type: looker_grid
    fields: [products.count, products.brand, products.category]
    pivots: [products.brand, products.category]
    hidden_fields: [products.category]
    sorts: [products.brand desc, products.category]
    limit: 500
    query_timezone: America/Toronto
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
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: []
    show_totals: true
    show_row_totals: true
    series_column_widths:
      products.count: 123
    series_cell_visualizations:
      products.count:
        is_active: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    row: 0
    col: 0
    width: 8
    height: 6
  - title: New Tile
    name: New Tile
    model: rie_test
    explore: order_items
    type: looker_grid
    fields: [products.brand, products.category, products.count]
    pivots: [products.brand, products.category]
    hidden_fields: [products.category]
    sorts: [products.brand, products.category]
    limit: 500
    query_timezone: America/Toronto
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
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    series_column_widths: {}
    row: 0
    col: 8
    width: 8
    height: 6
