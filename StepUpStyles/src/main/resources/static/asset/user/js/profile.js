app.controller("profile-ctrl", ['$scope', '$filter', '$http', function ($scope, $filter, $http) {
    $scope.imgUser = '';

    // $scope.uploadImage = async function () {
    //     var imageFile = document.getElementById('photo').files[0]; // Lấy tệp ảnh từ input
    //
    //     var storageRef = firebase.storage().ref(); // Tham chiếu đến Firebase Storage
    //     var imageRef = storageRef.child('users/' + imageFile.name); // Tạo đường dẫn lưu trữ cho ảnh
    //
    //     // Thực hiện tải ảnh lên Firebase Storage
    //     imageRef.put(imageFile).then(function (snapshot) {
    //         console.log('Uploaded a file:', snapshot);
    //         // Lấy URL của ảnh sau khi tải lên thành công
    //         imageRef.getDownloadURL().then(function (url) {
    //              $scope.imgUser = url;
    //             console.log('ủlt', $scope.imgUser);
    //             // Sử dụng URL để hiển thị ảnh hoặc lưu vào cơ sở dữ liệu
    //         });
    //     }).catch(function (error) {
    //         console.error('Upload failed:', error);
    //     });
    // };

    $scope.uploadImage = function() {
        var ref = firebase.storage().ref();
        var folder = 'users';
        var file = document.querySelector('#photo').files[0];
        var metadata = {
            contentType: file.type
        };
        var name = folder + '/' + file.name; // Tạo tên file với thư mục

        var uploadIMG = ref.child(name).put(file, metadata);

        return uploadIMG.then(snapshot => snapshot.ref.getDownloadURL())
            .then(url => {
                // Lưu đường dẫn ảnh vào biến $scope.form.imagePath
                $scope.imgUser = url;
                console.log("cc1: "+$scope.imgUser);
            });
    };

    $scope.user = {
        activaties: true,
        address: '',
        birthday: '',
        createdDate: '',
        email: '',
        fullName: '',
        image: '',
        phone: '',
        role: '',
        status: true,
    };

    $scope.submitForm = async function () {
        console.log("đã vào: ")
        // Lấy dữ liệu từ $scope để truyền đi

        // $scope.user.birthday = new Date($scope.user.birthday);
        // $scope.user.birthday = $filter('date')($scope.user.birthday, 'yyyy-MM-dd');

        console.log("cc: " + $scope.user.birthday)

        await $scope.uploadImage();

        var data = {
             fullName : $scope.user.fullName,
             birthday : $scope.user.birthday,
             phone : $scope.user.phone,
             image : $scope.imgUser,
             address : $scope.user.address
        }

        data.image = encodeURIComponent(data.image);
        console.log("img u: |" +data.image+ "|")

        // Chuyển đổi ngày sang định dạng 'yyyy-MM-dd'
        data.birthday = new Date(data.birthday);
        data.birthday = $filter('date')(data.birthday, 'yyyy-MM-dd');


        $http.put(`/user/updateProfile?fullName=${data.fullName}&birthday=${data.birthday}&phone=${data.phone}&image=${data.image}&address=${data.address}`, data)
            .then(function (response) {
                console.log('User updated successfully');
                // Xử lý kết quả sau khi cập nhật thành công
            })
            .catch(function (error) {
                console.log('Error updating user:', error);
                // Xử lý khi gặp lỗi
            });

        // Gửi dữ liệu đi sử dụng $http hoặc $resource của AngularJS
        // $http.post('/api/updateUserProfile', userData)
        //     .then(function(response) {
        //         // Xử lý kết quả sau khi gửi dữ liệu đi thành công
        //         console.log('Dữ liệu đã được gửi đi thành công');
        //     })
        //     .catch(function(error) {
        //         // Xử lý khi gặp lỗi
        //         console.error('Lỗi khi gửi dữ liệu: ', error);
        //     });

    };

    $scope.getDataFromAPI = function () {

        $http.get('/user/getUserCurrent')
            .then(function (response) {
                $scope.user = response.data;
                // Xử lý dữ liệu nhận được từ API ở đây
                $scope.user.createdDate = $scope.convertDateFormat($scope.user.createdDate);
            })
            .catch(function (error) {
                // Xử lý lỗi khi gọi API
                console.error('Lỗi khi gọi API: ', error);
            });
    };
    $scope.getDataFromAPI();


    // $scope.updateProfile = function(){
    //     $http.put('/user/updateProfile' + $scope.user)
    //         .then(function(response) {
    //             console.log(' profile ok');
    //         })
    //         .catch(function(error) {
    //             // Xử lý khi gặp lỗi
    //             console.log(' profile lỏd');
    //         });
    // }


    // convertDateFormat
    $scope.convertDateFormat = function (input) {
        if (!input) return '';
        var date = new Date(input);
        var formattedDate =
            ('0' + date.getDate()).slice(-2) +
            '/' +
            ('0' + (date.getMonth() + 1)).slice(-2) +
            '/' +
            date.getFullYear();
        return formattedDate;
    };

}]);