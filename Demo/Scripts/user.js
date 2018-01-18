$(document).ready(function () {
    LoadData();
});

function FormNewRecord(result) {
    var html = '';
    $.each(result, function (key, item) {
        html += '<tr>';
        html += '<td>' + item.UserId + '</td>';
        html += '<td class="userName">' + item.Name + '</td>';
        html += '<td class="userAge">' + item.Age + '</td>';
        html += '<td><a href="#" onclick="return GetById(' + item.UserId + ')" id="edit' + item.UserId + '">Edit</a> | <a href="#" onclick="Delete(' + item.UserId + ')">Delete</a></td>';
        html += '</tr>';
    });
    $('.tbody').html(html);
}

function LoadData() {
    $.ajax({
        url: "/Home/GetAllUsers",
        type: "GET",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: true,
        success: function (result) {
            FormNewRecord(result);
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}

function AddUpdateUser() {
    var res = ValidateValues();
    if (res == false) {
        return false;
    }
    var empObj = {
        UserId: $('#UserId').val(),
        Name: $('#Name').val(),
        Age: $('#Age').val()
    };
    $.ajax({
        url: "/Home/AddUpdateUser",
        data: JSON.stringify(empObj),
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (result) {
            $('#userModal').modal('hide');
            FormNewRecord(result);
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}

function GetById(userId) {
    var edit = $("#edit" + userId);
    var row = edit.closest("tr");
    $('#Name').css('border-color', 'lightgrey');
    $('#Age').css('border-color', 'lightgrey');
    $('#UserId').val(userId);
    $('#Name').val(row.find("td.userName")[0].innerHTML);
    $('#Age').val(row.find("td.userAge")[0].innerHTML);
    $('#userModal').modal('show');
    $('#btnUpdate').show();
    $('#btnAdd').hide();
    return false;
}

function Delete(userId) {
    var alertMessage = confirm("Are you sure you want to delete this Record?");
    if (alertMessage) {
        $.ajax({
            url: "/Home/Delete",
            data: { 'userId': userId },
            type: "POST",
            dataType: "json",
            success: function (result) {
                FormNewRecord(result);
            },
            error: function (errormessage) {
                alert(errormessage.responseText);
            }
        });
    }
}

function ClearTextBox() {
    $('#UserId').val("");
    $('#Name').val("");
    $('#Age').val("");
    $('#btnUpdate').hide();
    $('#btnAdd').show();
    $('#Name').css('border-color', 'lightgrey');
    $('#Age').css('border-color', 'lightgrey');
}

function ValidateValues() {
    var isValid = true;
    var pattern = /^[0-9]+$/;

    if ($('#Name').val().trim() == "") {
        $('#Name').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#Name').css('border-color', 'lightgrey');
    }

    if ($('#Age').val().trim() == "") {
        $('#Age').css('border-color', 'Red');
        isValid = false;
    }
    else if (parseInt($('#Age').val().trim()) <= 0) {
        $('#Age').css('border-color', 'Red');
        isValid = false;
    }
    else if (!pattern.test($('#Age').val().trim())) {
        $('#Age').css('border-color', 'Red');
        isValid = false;
    }
    else {
        $('#Age').css('border-color', 'lightgrey');
    }
    return isValid;
}