view: products {
  sql_table_name: demo_db2.products ;;
  #drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

#   filter: category_filter {
#     type: string
#     sql: {% condition category_filter %} ${category} {% endcondition %} ;;
#   }
#
#   filter: brand_filter {
#     type: string
#     sql: {% condition brand_filter %} ${brand} {% endcondition %} ;;
#   }

  dimension: filter_test {
    label: "イベント種別"
    description: "覇者の塔や裏覇者の塔などの種別"
    type: string
    case: {
      when: {
        label: "覇者の塔"
        sql: ${rank} = 1 ;;
      }
      when: {
        label: "裏覇者の塔"
        sql: ${rank} = 2 ;;
      }
    }
  }

  dimension: filter_test2 {
    label: "イベント種別 2"
    description: "覇者の塔や裏覇者の塔などの種別"
    type: string
    case: {
      when: {
        label: "覇者の塔"
        sql: ${rank} = 1 ;;
      }
      when: {
        label: "裏覇者の塔"
        sql: ${rank} = 2 ;;
      }
      when: {
        label: "english"
        sql: ${rank} = 2 ;;
      }
      when: {
        label: "special chars § @ Å"
        sql: ${rank} = 2 ;;
      }
    }
  }

  dimension: filter_test3 {
    type: string
    case: {
      when: {
        label: "english"
        sql: ${rank} = 2 ;;
      }
      when: {
        label: "more english"
        sql: ${rank} = 2 ;;
      }
    }
  }

  dimension: filter_test4 {
    type: string
    case: {
      when: {
        label: "special chars § @ Å"
        sql: ${rank} = 2 ;;
      }
      when: {
        label: "ä Õ ą "
        sql: ${rank} = 2 ;;
      }
    }
  }

  dimension: filter_test_5 {
    description: "覇者の塔や裏覇者の塔などの種別"
    type: string
    case: {
      when: {
        label: "覇者の塔"
        sql: ${rank} = 1 ;;
      }
      when: {
        label: "裏覇者の塔"
        sql: ${rank} = 2 ;;
      }
    }
  }

  dimension: brand {
    type: string
    #suggestions: ["10 Deep","180s","1veMoon"]
    #hidden: yes
    html: {{value}} <br> ~;;
    #html: <b><a href="https://www.google.com/search?q={{value}}">{{ value }}</a></b> ;;
    # link: {
    #   label: "Google brand name"
    #   #url: "https://www.google.com/"
    #   icon_url: "https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg"
    #     url: "/dashboards/3656?brand={{ value }}&f[products.brand]={{ _filters['products.brand'] | url_encode }}"
    # }
    # link: {
    #   label: "takes the values of two separate fields and passes it to the next dashboard filters"
    #   url: "/dashboards/3656?brand={{ value }}&Category={{ products.category._value }}"
    # }
    # link: {
    #   label: "takes the value of the date filter in dashboardA and passes it into dashboardB"
    #   url: "/dashboards/3656?date={{ _filters['orders.created_date'] | url_encode }}"
    # }
    # link: {
    #   label: "take the values of the field you drill on and passes into the explore filter"
    #   url: "/explore/rie_test/order_items?fields=users.state,users.count,products.brand&f[products.brand]={{ _filters['products.brand'] | url_encode }}"
    # }
    # link: {
    #   label: "take the value of the filters in dashboardA and passes it into the explore"
    #   url: "/explore/rie_test/order_items?fields=users.state,users.count,products.brand&f[products.brand]={{ _filters['products.brand'] | url_encode }}"
    # }
    #order_by_field: sort
    sql: ${TABLE}.brand ;;
    #html:<div style="border:3px solid black; width:100%; height:100%" /div>;;
  }

#   dimension: sort {
#     type: number
#     sql: case when ${brand}='Acura' then '1'
#          else '2'
#          end;;
#   }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    # html: {% if {{products.category._value}} == "Jeans" %}
    #   in xxx scale
    #   {% endif %};;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
    html:
        {% if value == "Men" %}
      {{ rendered_value }} This is boy</font>
    {% elsif value == "Women" %}
      {{ rendered_value }} This is girl</font>
    {% else %}
      <font color="darkred">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  parameter: filter_products {
    type: unquoted
    allowed_value: {
      label: "brand"
      value: "brand"
    }
    allowed_value: {
      label: "category"
      value: "category"
    }
  }

  parameter: filter_brand {
    type: unquoted
    allowed_value: {
      label: "brand"
      value: "brand"
    }
    allowed_value: {
      label: "all brand"
      value: "allbrand"
    }
  }

  dimension: values {
    type: string
    sql: {% if filter_products._parameter_value == 'brand' %}
          ${brand}
         {% elsif filter_products._parameter_value == 'category' %}
          ${category}
         {% else %}
          1=1
         {% endif %};;
  }

  dimension: item_name {
    tags: ["phone"]
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
    sql: 1 ;;
      html:  {% if category._value %}
          <font color="pink"> {{ category._value }} </font>
          {% endif %};;
    }

#     dimension: test_2 {
#       type: string
#       link: {
#         label: "Link By Media Dashboard"
#         url: "{{test._value}}"
#       }
#     }

    measure: count {
      type: count
#     html: {% if {{products.category._value}} == "Dresses" %}
#           <font color="pink">{{value}}%</font>
#           {% endif %};;
#     filters: {
#           field: brand
#           value: "-Speedo"
#     }
      # link: {
      #   label: "Drill Look"
      #   url:"/looks/10852?&&f[products.brand]={{ _filters['products.brand'] | url_encode }}"
      # }
      # link: {
      #   label: "takes the value of the date filter in dashboardA and passes it into dashboardB"
      #   url: "/dashboards/3656?date={{ _filters['orders.created_date'] | url_encode }}"
      # }
      #drill_fields: [id, item_name, inventory_items.count]

    }

    measure: total {
      type: sum
      sql: ${retail_price} ;;
#       sql: case ${retail_price} is null then '0'
#          else ${retail_price}
#          end;;
    }
    measure: total_2 {
      type: sum
      sql: case when ${department}= 'Men' then ${retail_price} + ${retail_price}
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
#     sql:
#     CASE WHEN ${count} > 30
#     THEN ${count} * 30
#     ELSE ${count} * 100
#     END ;;
      drill_fields: [category]
    }
    measure: avg {
      type: average
      sql: ${retail_price};;
      value_format_name: decimal_2
    }

    measure: inquerytest {
      type: number
      sql:
        {% if department._in_query %}
        ${count}
        {% else %}
        CASE WHEN ${brand} = "Acura"
        THEN ${total}
        ELSE
        null
        END
        {% endif %}
         ;;
    }


  }
