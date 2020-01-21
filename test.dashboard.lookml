- dashboard: test1
  title: test1
  layout: newspaper
  elements:
  - title: fullgauge
    name: fullgauge
    model: rie_test
    explore: users
    type: Fill Gauge
    fields: [users.percentage_states, users.created_month]
    fill_fields: [users.created_month]
    sorts: [users.created_month desc]
    limit: 500
    query_timezone: America/Toronto
    series_types: {}
    hidden_fields: []
    y_axes: []
    row: 0
    col: 0
    width: 8
    height: 6
  - name: full2
    title: full2
    model: rie_test
    explore: users
    type: Fill Gauge
    fields: [users.percentage_states, users.age]
    filters:
      users.age: '60'
    sorts: [users.percentage_states desc]
    limit: 500
    query_timezone: America/Toronto
    series_types: {}
    hidden_fields: []
    y_axes: []
    row: 0
    col: 8
    width: 8
    height: 6
  - title: full3
    name: full3
    model: rie_test
    explore: users
    type: Fill Gauge
    fields: [users.percentage_states, users.age]
    filters:
      users.age: '50'
    sorts: [users.percentage_states desc]
    limit: 500
    query_timezone: America/Toronto
    series_types: {}
    hidden_fields: []
    y_axes: []
    row: 0
    col: 16
    width: 8
    height: 6
  - name: fullgauge
    title: fullgauge
    model: rie_test
    explore: users
    type: Fill Gauge
    fields: [users.percentage_states, users.created_month]
    fill_fields: [users.created_month]
    sorts: [users.created_month desc]
    limit: 500
    query_timezone: America/Toronto
    series_types: {}
    hidden_fields: []
    y_axes: []
    row: 6
    col: 0
    width: 8
    height: 6
  - name: full4
    title: full4
    model: rie_test
    explore: users
    type: Fill Gauge
    fields: [users.percentage_states, users.age]
    filters:
      users.age: '20'
    sorts: [users.percentage_states desc]
    limit: 500
    query_timezone: America/Toronto
    series_types: {}
    hidden_fields: []
    y_axes: []
    row: 6
    col: 8
    width: 8
    height: 6
  - name: full6
    title: full6
    model: rie_test
    explore: users
    type: Fill Gauge
    fields: [users.percentage_states, users.age]
    filters:
      users.age: '22'
    sorts: [users.percentage_states desc]
    limit: 500
    query_timezone: America/Toronto
    series_types: {}
    hidden_fields: []
    y_axes: []
    row: 6
    col: 16
    width: 8
    height: 6
  - name: full7
    title: full7
    model: rie_test
    explore: users
    type: Fill Gauge
    fields: [users.percentage_states, users.age]
    filters:
      users.age: '23'
    sorts: [users.percentage_states desc]
    limit: 500
    query_timezone: America/Toronto
    series_types: {}
    hidden_fields: []
    y_axes: []
    row: 12
    col: 8
    width: 8
    height: 6
  - name: full5
    title: full5
    model: rie_test
    explore: users
    type: Fill Gauge
    fields: [users.percentage_states, users.age]
    filters:
      users.age: '21'
    sorts: [users.percentage_states desc]
    limit: 500
    query_timezone: America/Toronto
    series_types: {}
    hidden_fields: []
    y_axes: []
    row: 12
    col: 0
    width: 8
    height: 6
  - name: Number of orders based on state
    title: Number of orders based on state
    model: rie_test
    explore: order_items
    type: looker_area
    fields: [orders.count, users.state]
    sorts: [orders.count desc]
    limit: 500
    query_timezone: America/Los_Angeles
    series_types: {}
    up_color: "#FFCA28"
    down_color: "#EF5350"
    total_color: "#66BB6A"
    hidden_fields: []
    y_axes: []
    row: 12
    col: 16
    width: 8
    height: 6
  - name: testttttt
    title: testttttt
    model: rie_test
    explore: order_items
    type: looker_area
    fields: [orders.count, users.state]
    sorts: [orders.count desc]
    limit: 500
    query_timezone: America/Los_Angeles
    series_types: {}
    up_color: "#FFCA28"
    down_color: "#EF5350"
    total_color: "#66BB6A"
    hidden_fields: []
    y_axes: []
    row: 18
    col: 0
    width: 8
    height: 6
  - title: New Tile
    name: New Tile
    model: thelook_clean
    explore: order_items
    type: table
    fields: [users.count_email, users.city]
    filters: {}
    sorts: [users.count_email desc]
    limit: 500
    query_timezone: America/Toronto
    hidden_fields: []
    y_axes: []
    listen:
      Unquoted filter: users.filter_email
    row: 18
    col: 8
    width: 8
    height: 6
  filters:
  - name: Unquoted filter
    title: Unquoted filter
    type: field_filter
    default_value: a
    allow_multiple_values: true
    required: false
    model: thelook_clean
    explore: order_items
    listens_to_filters: []
    field: users.filter_email
