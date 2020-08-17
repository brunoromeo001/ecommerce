<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>Lista de Produtos</h1>
		<ol class="breadcrumb">
			<li><a href="/admin"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="/admin/products">Produtos</a></li>
			<li class="active"><a href="#">Cadastrar</a></li>
		</ol>
	</section>
	
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-success">
					<div class="box-header with-border">
						<h3 class="box-title">Novo Produto</h3>
					</div>
					<!-- /.box-header -->
					<!-- form start -->					
					<form role="form" action="/admin/products/create" method="post" enctype="multipart/form-data">
						<div class="box-body">
							<div class="form-group">
								<label for="desproduct">Nome da produto:</label>
								<input type="text" class="form-control" id="desproduct" name="desproduct" placeholder="Digite o nome do produto" />
							</div>
							<div class="form-group">
								<label for="vlprice">Preço:</label>
								<div class="input-group">								
									<span class="input-group-addon">R$</span>
									<input type="number" class="form-control" id="vlprice" name="vlprice"  placeholder="R$ 0.00" />
								</div>
							</div> 							
							<div class="form-group">
								<label for="vlwidth">Largura:</label>
								<div class="input-group">								
									<span class="input-group-addon">cm</span>								
									<input type="number" class="form-control" id="vlwidth" name="vlwidth" step="0.01" placeholder="0.00 cm" />
								</div>
							</div>
							<div class="form-group">
								<label for="vlheight">Altura:</label>
								<div class="input-group">								
									<span class="input-group-addon">cm</span>
									<input type="number" class="form-control" id="vlheight" name="vlheight" step="0.01" placeholder="0.00 cm" />
								</div>	
							</div>
							<div class="form-group">
								<label for="vllength">Comprimento:</label>
								<div class="input-group">								
									<span class="input-group-addon">cm</span>
									<input type="number" class="form-control" id="vllength" name="vllength" step="0.01" placeholder="0.00 cm" />
								</div>	
							</div>
							<div class="form-group">
								<label for="vlweight">Peso:</label>
								<div class="input-group">								
									<span class="input-group-addon">Kg</span>
									<input type="number" class="form-control" id="vlweight" name="vlweight" step="0.01" placeholder="0.00 kg" />
								</div>
							</div>
							<div class="form-group">
								<label for="desurl">URL:</label>
								<div class="input-group">								
									<span class="input-group-addon"><i class="fa fa-link"></i> </span>
									<input type="text" class="form-control" id="desurl" name="desurl" />
								</div>
							</div>
							<div class="form-group">
								<label for="file">Foto</label>
								<input type="file" class="form-control" id="file" name="file">
								<div class="box-body">
                  <img class="img-responsive" id="image-preview" src="/res/site/img/product.jpg" alt="Photo">
                </div> 
					 		</div>
						</div>
						<!-- /.box-body -->
						<div class="box-footer">
						<button type="submit" class="btn btn-success">Cadastrar</button>
						<a href="/admin/products" class="btn btn-danger">Cancelar</a>
						</div>
					</form>
				</div>
			</div>
		</div>

	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<script>
	document.querySelector('#file').addEventListener('change', function(){
		
		var file = new FileReader();
	
		file.onload = function() {
			
			document.querySelector('#image-preview').src = file.result;
	
		}
	
		file.readAsDataURL(this.files[0]);
	
	});
	</script>