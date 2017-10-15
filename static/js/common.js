function getJSON (url, callback){
    $.ajax({
        type: "GET",
        url:url,
        success: function (data) {
            json = JSON.parse(data);
            callback(json);
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

