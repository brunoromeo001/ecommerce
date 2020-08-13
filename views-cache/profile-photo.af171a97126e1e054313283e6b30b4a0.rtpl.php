<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>	Perfil	</h1>
		<ol class="breadcrumb">
			<li><a href="/admin"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="/admin/profile">Perfil</a></li>			
		</ol>
	</section>

	<!-- Main content -->
	<section class="content">
		<div class="row">		
			<div class="col-md-12">															
				
				<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title">	Foto</h3>							
					</div>
					<div class="box-body">
						<div class="row">                
							<div class="col-md-3">						
								<?php require $this->checkTemplate("profile-menu");?>
							</div>
							
							<div class="col-md-9">                                								
								<div class="row">
									<div class="col-md-4">
										<img id='img-upload' src="<?php echo htmlspecialchars( $user["userPhoto"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" class="img-thumbnail"  />
									</div>										
									<div class="col-md-8">
										<div class="form-group">
											<label>Selecione a imagem:</label>
											<div class="input-group">
												<input type="file" name="upload_image" id="upload_image" />										
											</div>

											<div class="box-body">
												<img class="img-responsive" id="image-preview" src="" >
											</div>
											<input type="text" class="form-control" name="id_user" value="<?php echo getIdUser(); ?>" style="display: none;" />	
										</div>
									</div>
								</div>																	
							</div>
						</div>						
					</div>					
				</div>
			</div>
			<div id="uploadimageModal" class="modal" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Recortar & Salvar</h4>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md-8 text-center">
									  <div id="image_demo" style="width:350px; margin-top:30px"></div>
								</div>
								<div class="col-md-4" style="padding-top:30px;">
									<br />
									<br />
									<br/>
									  <button class="btn btn-success crop_image">Recortar & Salvar</button>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
						</div>
					</div>
				</div>
			</div>
		</div>

	</section>
	<!-- /.content -->
	
</div>
<!-- /.content-wrapper -->

<script>

	scripts.push(function() {
		$image_crop = $('#image_demo').croppie({
			enableExif: true,
			viewport: {
				width:200,
				height:200,
				type:'square' //circle
			},
			boundary:{
				width:300,
				height:300
			}
		});
	
		$('#upload_image').on('change', function(){
			var reader = new FileReader();
			reader.onload = function (event) {
				$image_crop.croppie('bind', {
					url: event.target.result
				}).then(function(){
					console.log('jQuery bind complete');
				});
			}
			reader.readAsDataURL(this.files[0]);
			$('#uploadimageModal').modal('show');
		});
	
		$('.crop_image').click(function(event){
			$image_crop.croppie('result', {
				type: 'canvas',
				size: 'viewport',	  
			}).then(function(response){
				$.ajax({
					type: "POST",
					url:"/admin/profile/photo",
					data:{"image": response},		
					success:function(data)
					{
						$('#uploadimageModal').modal('hide');
						
					}
				});
			})
		});
				
		
	});
	</script>
