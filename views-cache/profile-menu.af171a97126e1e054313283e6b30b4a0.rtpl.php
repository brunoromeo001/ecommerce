<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="list-group" id="menu">
	
	<?php if( $pageName == 'profile' ){ ?>
		<a href="/admin/profile" class="list-group-item list-group-item-action active">Editar Dados</a>
	<?php }else{ ?>
		<a href="/admin/profile" class="list-group-item list-group-item-action">Editar Dados</a>
	<?php } ?>

	<?php if( $pageName == 'change-password' ){ ?>
		<a href="/admin/profile/change-password" class="list-group-item list-group-item-action active">Alterar Senha</a>	
	<?php }else{ ?>
		<a href="/admin/profile/change-password" class="list-group-item list-group-item-action">Alterar Senha</a>	
	<?php } ?>

	<?php if( $pageName == 'photo' ){ ?>
		<a href="/admin/profile/photo" class="list-group-item list-group-item-action active">Foto</a>
	<?php }else{ ?>
		<a href="/admin/profile/photo" class="list-group-item list-group-item-action">Foto</a>
	<?php } ?>
	<a href="/form_teste/logout" class="list-group-item list-group-item-action">Sair</a>
</div>