function getJSON (url){
    $.ajax({
        type: "GET",
        url:'/api/v1/listings',
        success: function (data, status, jqXHR) {
            return data;
        }
    });
}

function postJSON (url, data){
    $.ajax({
        type: "POST",
        url: url,
        data: data,
        success: success,
        dataType: json
    });
}