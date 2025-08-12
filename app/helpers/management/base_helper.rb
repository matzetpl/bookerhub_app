module Management
  module BaseHelper
    def management_sidebar_link_to(url, label)
      link_to label, url, class: "block py-2 px-4 hover:text-white hover:bg-gray-500"
    end

    def management_table_th(label, classes = "")
      content_tag(:th, label, class: "px-4 py-2 text-left font-semibold text-gray-600 #{classes}")
    end

    def management_table_th_action
      content_tag(:th, :actions, class: "px-4 py-2 text-left font-semibold text-gray-600", style: "width:120px;")
    end

    def management_table_td(classes = "", &block)
      content_tag(:td, class: "px-4 py-2 #{classes}", &block)
    end



    def management_table_button(text, url = nil, type = "default", class_css: "", turbo: false, button: false, method: "GET", remote: false, data: {})
      case type
      when "edit"
        button_class = "bg-blue-500 text-white rounded px-3 py-1"
      when "delete"
        button_class = "bg-red-500 text-white rounded px-3 py-1"
      else
        button_class = "bg-gray-500 text-white rounded px-3 py-1"
      end

      class_string = ""
      class_string = class_string + button_class + class_css

      data_params = {
        turbo: turbo,
        remote: false
      }

      if method.to_s == "delete"
        data_params[:controller]  = "swal-confirm"
        data_params[:action] = "click->swal-confirm#delete"
      end


      data_params = data_params.merge(data)
      if button
        button_to text, url, method: method, remote: remote, data: data_params, class: class_string
      else
        link_to text, url, remote: remote, data: data_params, class: class_string
      end
    end
  end
end
