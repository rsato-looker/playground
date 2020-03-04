view: products {
  sql_table_name: demo_db2.products ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    #html: <b><a href="https://www.google.com/search?q={{value}}">{{ value }}</a></b> ;;
#      link: {
#        label: "Google brand name"
#        url: "https://www.google.com/"
#        icon_url: "https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg"
#         url: "/dashboards/3656?brand={{ value }}&f[products.brand]={{ _filters['products.brand'] | url_encode }}"
#      }
    link: {
      label: "Drill Dashboard"
      url: "/dashboards/3656?brand={{ value }}&Category={{ _filters['products.category'] | url_encode }}"
    }
    order_by_field: sort
    sql: ${TABLE}.brand ;;
  }

  dimension: sort {
    type: number
    sql: case when ${brand}='Acura' then '1'
         else '2'
         end;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  dimension: test {
    type: string
    sql:
    case when
    ${category} is '%Sleep%Lounge%' then 'yes'
    then 'no';;
  }

  measure: count {
    type: count
    html: {% if {{products.category._value}} == "Dresses" %}
          <font color="pink">{{value}}%</font>
          {% endif %};;
#     filters: {
#           field: brand
#           value: "-Speedo"
#     }
    drill_fields: [id, item_name, inventory_items.count]

  }

  measure: total {
    type: sum
    sql: case ${retail_price} is null then '0'
         else ${retail_price}
         end;;
  }
  # if i do this way, drill down won't work
#   measure: count_category {
#     type: sum
#     sql:
#     case
#     when ${category} like '%Sleep%Lounge%'
#     then 1
#     else 0
#     end;;
#   }
  # But in this way, drill down will work
  measure: count_category2 {
    type: count_distinct
    sql: ${id} ;;
    filters: {
      field: category
      value: "%Pants%"
    }
    drill_fields: [category]
  }
  measure: avg {
    type: average
    sql: ${retail_price};;
    value_format_name: decimal_2
  }


}
