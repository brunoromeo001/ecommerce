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
						<h3 class="box-title">	Editar Dados</h3>							
					</div>
					<div class="box-body">
						<div class="row">                
							<div class="col-md-3">						
								<?php require $this->checkTemplate("profile-menu");?>
							</div>
							
							<div class="col-md-9">  
								<?php if( $profileMsg != '' ){ ?>
								<div class="alert alert-success">
									<?php echo htmlspecialchars( $profileMsg, ENT_COMPAT, 'UTF-8', FALSE ); ?>
									<button type="button" class="close" data-dismiss="alert" aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<?php } ?>
								
								<?php if( $profileError != '' ){ ?>
								<div class="alert alert-danger">
									<?php echo htmlspecialchars( $profileError, ENT_COMPAT, 'UTF-8', FALSE ); ?>
									<button type="button" class="close" data-dismiss="alert" aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<?php } ?>							
								<form method="post" action="/admin/profile">
									<div class="form-group">
										<label for="desperson">Nome:</label>
										<input type="text" class="form-control" id="desperson " name="desperson" placeholder="Digite o nome" />
									</div>
																		
									<div class="form-group">
										<label for="desemail">E-mail:</label>
										<input type="email" class="form-control" id="desemail" name="desemail" placeholder="Digite o e-mail" />
									</div>
									
									<button type="submit" class="btn btn-primary">Salvar</button>
									<a href="/admin/" class="btn btn-danger">Cancelar</a>
								</form>
							</div>
						</div>
						
					</div>					
				</div>
			</div>
		</div>

	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->


