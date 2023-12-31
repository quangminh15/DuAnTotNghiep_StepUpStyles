USE [stepupstyles]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertShippingAddress]    Script Date: 9/20/2023 7:34:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[SP_InsertShippingAddress]
    @user_id BIGINT,
    @default bit,
    @province nvarchar(255),
	@district nvarchar(255),
	@ward nvarchar(255),
    @name_receiver nvarchar(50),
    @phone_receiver char(10),
	@address_details nvarchar(255)
AS
BEGIN
    DECLARE @shipping_id BIGINT;

    
    SELECT @shipping_id = shipping_address_id
    FROM shipping_address
    WHERE users_id = @user_id;
	
	IF @shipping_id is null
	 BEGIN
        insert into shipping_address(users_id,name_receiver,phone_receiver,province,district,ward,address_details,default_address)
        values (@user_id,@name_receiver,@phone_receiver,@province,@district,@ward,@address_details,1)
    END
	ELSE
	Begin
		if @default = 1
		begin
			--finde the present default id 
			DECLARE @addressDefault_id BIGINT

			select @addressDefault_id = shipping_address_id
			from shipping_address 
			where users_id = @user_id and default_address =1
			
			 BEGIN
					UPDATE shipping_address
					SET default_address = 0
					WHERE shipping_address_id = @addressDefault_id;
			 END
				insert into shipping_address(users_id,name_receiver,phone_receiver,province,district,ward,address_details,default_address)
				values (@user_id,@name_receiver,@phone_receiver,@province,@district,@ward,@address_details,@default)
		end
		else
		Begin 
			insert into shipping_address(users_id,name_receiver,phone_receiver,province,district,ward,address_details,default_address)
				values (@user_id,@name_receiver,@phone_receiver,@province,@district,@ward,@address_details,@default)
		End
	End
END