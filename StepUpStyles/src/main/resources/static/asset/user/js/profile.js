
app.controller("profile-ctrl", function ($scope, $http) {
    $scope.imgUser= '';

    // Tải ảnh lên Firebase	bắt đầu
    // $scope.createImages = async function() {
    //     try {
    //         // Lấy tệp ảnh đã chọn từ trường input với id là "photo"
    //         const imageFile = document.querySelector('#photo').files[0];
    //
    //         if (!imageFile) {
    //             throw new Error("Chưa chọn ảnh để tải lên Firebase.");
    //         }
    //
    //         // Tạo một thư mục trên Firebase Storage để lưu trữ ảnh
    //         const storageRef = firebase.storage().ref();
    //         const imageRef = storageRef.child('users/' + imageFile.name);
    //
    //         // Tải tệp ảnh lên Firebase Storage
    //         const snapshot = await imageRef.put(imageFile);
    //
    //         // Lấy URL của ảnh sau khi tải lên Firebase
    //         const downloadURL = await snapshot.ref.getDownloadURL();
    //
    //         // Lưu URL vào biến $scope.form.brandImage hoặc nơi bạn muốn lưu
    //         $scope.imgUser = downloadURL;
    //     } catch (error) {
    //         // Xử lý lỗi khi tải ảnh lên Firebase
    //         throw error;
    //     }
    // };
    // Tải ảnh lên Firebase	Kết thúc

    $scope.uploadImage = function() {
        var imageFile = document.getElementById('photo').files[0]; // Lấy tệp ảnh từ input

        var storageRef = firebase.storage().ref(); // Tham chiếu đến Firebase Storage
        var imageRef = storageRef.child('users/' + imageFile.name); // Tạo đường dẫn lưu trữ cho ảnh

        // Thực hiện tải ảnh lên Firebase Storage
        imageRef.put(imageFile).then(function(snapshot) {
            console.log('Uploaded a file:', snapshot);
            // Lấy URL của ảnh sau khi tải lên thành công
            imageRef.getDownloadURL().then(function(url) {
                $scope.imgUser = url;
                console.log('File available at', $scope.imgUser);
                console.log('ủlt', url);
                // Sử dụng URL để hiển thị ảnh hoặc lưu vào cơ sở dữ liệu
            });
        }).catch(function(error) {
            console.error('Upload failed:', error);
        });
    };

})