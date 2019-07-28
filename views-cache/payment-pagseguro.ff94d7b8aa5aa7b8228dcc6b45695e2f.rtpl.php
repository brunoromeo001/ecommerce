<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Declaração do formulário -->  
<form method="post" action="https://pagseguro.uol.com.br/v2/checkout/payment.html">  
          
        <!-- Campos obrigatórios -->  
        <input name="receiverEmail" value="brunogfvot@hotmail.com" type="hidden">  
        <input name="currency" value="BRL" type="hidden">  
  
        <!-- Itens do pagamento (ao menos um item é obrigatório) -->  
		<?php $counter1=-1;  if( isset($products) && ( is_array($products) || $products instanceof Traversable ) && sizeof($products) ) foreach( $products as $key1 => $value1 ){ $counter1++; ?>
		
        <input name="itemId<?php echo htmlspecialchars( $counter1+1, ENT_COMPAT, 'UTF-8', FALSE ); ?>" value="<?php echo htmlspecialchars( $value1["idproduct"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" type="hidden">  
        <input name="itemDescription<?php echo htmlspecialchars( $counter1+1, ENT_COMPAT, 'UTF-8', FALSE ); ?>" value="<?php echo htmlspecialchars( $value1["desproduct"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" type="hidden">  
        <input name="itemAmount<?php echo htmlspecialchars( $counter1+1, ENT_COMPAT, 'UTF-8', FALSE ); ?>" value="<?php echo htmlspecialchars( $value1["vltotal"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" type="hidden">  
        <input name="itemQuantity<?php echo htmlspecialchars( $counter1+1, ENT_COMPAT, 'UTF-8', FALSE ); ?>" value="<?php echo htmlspecialchars( $value1["nrqtd"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" type="hidden">  
        <input name="itemWeight<?php echo htmlspecialchars( $counter1+1, ENT_COMPAT, 'UTF-8', FALSE ); ?>" value="<?php echo htmlspecialchars( $value1["vlweight"]*1000, ENT_COMPAT, 'UTF-8', FALSE ); ?>" type="hidden">  
		
        <?php } ?>	
		
        <!-- Código de referência do pagamento no seu sistema (opcional) -->  
        <input name="reference" value="<?php echo htmlspecialchars( $order["idorder"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" type="hidden">  
          
        <!-- Informações de frete (opcionais) -->  
        <input name="shippingType" value="1" type="hidden">  
        <input name="shippingAddressPostalCode" value="<?php echo htmlspecialchars( $order["deszipcode"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" type="hidden">  
        <input name="shippingAddressStreet" value="<?php echo utf8_encode($order["desaddress"]); ?>" type="hidden">  
        <input name="shippingAddressNumber" value="<?php echo utf8_encode($order["desnumber"]); ?>" type="hidden">  
        <input name="shippingAddressComplement" value="<?php echo utf8_encode($order["descomplement"]); ?>" type="hidden">  
        <input name="shippingAddressDistrict" value="<?php echo utf8_encode($order["desdistrict"]); ?>" type="hidden">  
        <input name="shippingAddressCity" value="<?php echo utf8_encode($order["descity"]); ?>" type="hidden">  
        <input name="shippingAddressState" value="<?php echo utf8_encode($order["desstate"]); ?>" type="hidden">  
        <input name="shippingAddressCountry" value="<?php echo utf8_encode($order["descountry"]); ?>" type="hidden">  
  
        <!-- Dados do comprador (opcionais) -->  
        <input name="senderName" value="<?php echo htmlspecialchars( $order["desperson"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" type="hidden">  
        <input name="senderAreaCode" value="<?php echo htmlspecialchars( $phone["areaCode"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" type="hidden">  
        <input name="senderPhone" value="<?php echo htmlspecialchars( $phone["number"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" type="hidden">  
        <input name="senderEmail" value="<?php echo htmlspecialchars( $order["desemail"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" type="hidden">  
  
        <!-- submit do form (obrigatório) -->  
 <!--        <input alt="Pague com PagSeguro" name="submit"  type="image"  src="https://p.simg.uol.com.br/out/pagseguro/i/botoes/pagamentos/120x53-pagar.gif"/>   -->          
</form> 

<script type="text/javascript">
	
	document.forms[0].submit();

</script>