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
				<?php if( $alterarSenhaError != '' ){ ?>
                <div class="alert alert-danger">
                    <?php echo htmlspecialchars( $alterarSenhaError, ENT_COMPAT, 'UTF-8', FALSE ); ?>
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
                </div>
                <?php } ?>
				
				<?php if( $alterarSenhaSuccess != '' ){ ?>
                <div class="alert alert-success">
                    <?php echo htmlspecialchars( $alterarSenhaSuccess, ENT_COMPAT, 'UTF-8', FALSE ); ?>
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
                </div>
                <?php } ?>
				
				
				<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title">	Alterar senha</h3>							
					</div>
					<div class="box-body">
						<div class="row">                
							<div class="col-md-3">						
								<?php require $this->checkTemplate("profile-menu");?>
							</div>
							
							<div class="col-md-9">                                
								<form action="/admin/profile/change-password" method="post">
									<div class="form-group">
										<label for="senha_atual">Senha atual:</label>
										<input type="password" class="form-control" id="senha_atual" name="senha_atual" placeholder="Digite a senha atual." />
									</div>
									
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label for="nova_senha">Nova senha:</label>
												<input type="password" class="form-control" id="nova_senha" name="nova_senha" placeholder="Digite a nova senha." />
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label for="nova_senha_confirma">Confirme a nova senha:</label>
												<input type="password" class="form-control" id="nova_senha_confirma" name="nova_senha_confirma" placeholder="Confirme a nova senha." />											
											</div>
										</div>
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