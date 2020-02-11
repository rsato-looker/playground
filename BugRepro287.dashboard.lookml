- dashboard: bugrepro281721
  title: BugRepro281721
  layout: newspaper
  elements:
  - title: TwoPivotedColumns
    name: TwoPivotedColumns
    model: rie_bug_repro
    explore: order_items
    type: table
    fields: [products.count, products.category, products.brand]
    hidden_fields: [products.category]
    pivots: [products.category, products.brand]
    sorts: [products.category, products.brand]
    limit: 500
    query_timezone: America/Los_Angeles
    row: 0
    col: 0
    width: 21
    height: 5
  - title: TwoPivotedColumns-TableNext
    name: TwoPivotedColumns-TableNext
    model: rie_bug_repro
    explore: order_items
    type: looker_grid
    fields: [products.count, products.category, products.brand]
    hidden_fields: [products.category]
    pivots: [products.category, products.brand]
    sorts: [products.category, products.brand]
    limit: 500
    query_timezone: America/Los_Angeles
    series_types: {}
    series_column_widths: {}
    row: 5
    col: 0
    width: 8
    height: 6
