{*
* 2007-2014 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2014 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{capture name=path}{l s='Our stores'}{/capture}

<h2><a href="{$link->getPageLink('contact-form.php')}" title="{l s='Si eres profesional contacta con nosotros para formar parte de nuestra red de talleres'}">{l s='Si eres profesional contacta con nosotros para formar parte de nuestra red de talleres'}</a></h2>

{if $simplifiedStoresDiplay}
	{if $stores|@count}
		<p class="store-title">
			<strong class="dark">
				{l s='Here you can find our store locations. Please feel free to contact us:'}
			</strong>
		</p>
	    <table class="table table-bordered">
	    	<thead>
            	<tr>
                	<th class="logo">{l s='Logo'}</th>
                    <th class="name">{l s='Store name'}</th>
                    <th class="address">{l s='Store address'}</th>
                    <th class="store-hours">{l s='Working hours'}</th>
                </tr>
            </thead>
			{foreach $stores as $store}
				<tr class="store-small">
					<td class="logo">
						{if $store.has_picture}
							<div class="store-image">
								<img src="{$img_store_dir}{$store.id_store}-medium_default.jpg" alt="{$store.name|escape:'html':'UTF-8'}" width="{$mediumSize.width}" height="{$mediumSize.height}"/>
							</div>
						{/if}
					</td>
					<td class="name">
						{$store.name|escape:'html':'UTF-8'}
					</td>
		            <td class="address">
		            {assign value=$store.id_store var="id_store"}
		            {foreach from=$addresses_formated.$id_store.ordered name=adr_loop item=pattern}
	                    {assign var=addressKey value=" "|explode:$pattern}
	                    {foreach from=$addressKey item=key name="word_loop"}
	                        <span {if isset($addresses_style[$key])} class="{$addresses_style[$key]}"{/if}>
	                            {$addresses_formated.$id_store.formated[$key|replace:',':'']|escape:'html':'UTF-8'}
	                        </span>
	                    {/foreach}
	                {/foreach}
	                	<br/>
						{if $store.phone}<br/>{l s='Phone:'} {$store.phone|escape:'html':'UTF-8'}{/if}
						{if $store.fax}<br/>{l s='Fax:'} {$store.fax|escape:'html':'UTF-8'}{/if}
						{if $store.email}<br/>{l s='Email:'} {$store.email|escape:'html':'UTF-8'}{/if}
						{if $store.note}<br/><br/>{$store.note|escape:'html':'UTF-8'|nl2br}{/if}
					</td>
		            <td class="store-hours">
						{if isset($store.working_hours)}{$store.working_hours}{/if}
		            </td>
				</tr>
			{/foreach}
	    </table>
	{/if}
{else}
	<div id="map"></div>
    <p><strong>{l s='Escriba'}</strong>{l s='  en el buscador la población en la que se encuentra o su código postal  y le indicará, si existen, talleres colaboradores próximos en los que puede cambiar a su vehículo, a precios ventajosos, los productos adquiridos en nuestra web,  esto gracias a un acuerdo de colaboración entre dichos talleres y recambium.com.'}</p>
	<p class="store-title">
		<strong class="dark">
			{l s='Enter a location (e.g. zip/postal code, address, city or country) in order to find the nearest stores.'}
		</strong>
	</p>
    <div class="store-content">
        <div class="address-input">
            <label for="addressInput">{l s='Your location:'}</label>
            <input class="form-control" type="text" name="location" id="addressInput" value="{l s='Address, zip / postal code, city, state or country'}" />
        </div>
        <div class="radius-input">
            <label for="radiusSelect">{l s='Radius:'}</label> 
            <select name="radius" id="radiusSelect" class="form-control">
                <option value="15">15</option>
                <option value="25">25</option>
                <option value="50">50</option>
                <option value="100">100</option>
            </select>
            <img src="{$img_ps_dir}loader.gif" class="middle" alt="" id="stores_loader" />
        </div>
        <div>
            <button name="search_locations" class="button btn btn-default button-small">
            	<span>
            		{l s='Search'}<i class="icon-chevron-right right"></i>
            	</span>
            </button>
        </div>
    </div>
    <div class="store-content-select selector3">
    	<select id="locationSelect" class="form-control">
    		<option>-</option>
    	</select>
    </div>

	<table id="stores-table" class="table table-bordered">
    	<thead>
			<tr>
                <th class="num">#</th>
                <th>{l s='Store'}</th>
                <th>{l s='Address'}</th>
                <th>{l s='Distance'}</th>
            </tr>		
        </thead>
        <tbody>
        </tbody>
	</table>
    
    <p><strong>{l s='Contacte con el responsable del taller'}</strong>{l s=' y solicite hora para realizar los trabajos que quiera realizar en su  vehículo.'}</p>
    <p><strong>{l s='Acuda a la cita '}</strong>{l s=' con los productos adquiridos en recambium.com y la correspondiente factura que acredite ante el taller dicha compra. Esta acreditación le permitirá acogerse al acuerdo de colaboración y beneficiarse de los precios acordados.'}</p>
    <p>{l s='La relación de '}<strong>{l s='precios acordados '}</strong>{l s='(exclusivamente para la mano de obra) para realizar las distintas operaciones (siempre aportando el cliente el producto, adquirido en recambium.com) son los siguientes:'}</p>
    <table cellpadding="0" cellspacing="0" style="margin-left:10px; border: 1px solid;">
		<tr>
        	<td style="border: 1px solid;"><strong>{l s='Servicio: Cambio de Aceite y Filtros'}</strong></td>
			<td style="border: 1px solid;">{l s='Importe total a pagar por el cliente. '}<strong>{l s='IVA incluido(*)(**)'}</strong></td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">{l s='Cambio de aceite del motor'}</td>
			<td style="text-align: center;border: 1px solid;">{l s='12 €'}</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">{l s='Cambio del filtro del aceite'}</td>
			<td style="text-align: center;border: 1px solid;">{l s='6 €'}</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">{l s='Cambio del filtro de aire'}</td>
			<td style="text-align: center;border: 1px solid;">{l s='3 €'}</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">{l s='Cambio del filtro de combustible (gasolina o gasóleo)'}</td>
			<td style="text-align: center;border: 1px solid;">{l s='9 €'}</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">{l s='Cambio del filtro de habitáculo'}</td>
			<td style="text-align: center;border: 1px solid;">{l s='5 €'}</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;"><strong>{l s='Total  Servicio cambio de aceite y juego completo de filtros'}</strong></td>
			<td style="text-align: center;border: 1px solid;"><strong>{l s='35 €'}</strong></td>
        </tr>
    </table>
    <p>&nbsp;</p>
    <p>&nbsp;&nbsp;&nbsp;<strong>(*)</strong>{l s=' Precio no válido para vehículos con complejidad en el desmontaje y montaje de filtros. En ese caso será el taller quien le informe y si el cliente está conforme el taller le aplicará su propia tarifa. '}&nbsp;</br>    
    &nbsp;&nbsp;&nbsp;<strong>(**)</strong>{l s=' Para que se apliquen estos precios es imprescindible hacer un gasto mínimo en el taller de 18 € (cambio de aceite de motor y filtro de aceite. No válidos para el cambio de un sólo filtro). '}&nbsp;</p>    
    <p>&nbsp;</p>
    <table cellpadding="0" cellspacing="0" style="margin-left:10px; border: 1px solid;">
		<tr>
        	<td style="border: 1px solid;"><strong>{l s='Servicios adicionales'}</strong></td>
			<td style="width:385px;border: 1px solid;">&nbsp;</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">{l s='Sustitución de escobillas (1, 2, o 3)'}</td>
			<td style="text-align: center;border: 1px solid;">{l s='3 €'}</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">{l s='Cambio del líquido del circuito de frenos'}</td>
			<td style="text-align: center;border: 1px solid;">{l s='30 €'}</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">{l s='Cambio del líquido del circuito de refrigeración'}</td>
			<td style="text-align: center;border: 1px solid;">{l s='25 €'}</td>
        </tr>
    </table>
    <p>&nbsp;</p>
    <p>{l s='El responsable del taller elaborará la correspondiente orden de trabajo con las operaciones que el cliente demanda, facturándole posteriormente el trabajo realizado.'}</p>
    <p>{l s='Al margen de las operaciones encargadas por el cliente, el taller realizará una revisión al vehículo, totalmente gratuita, chequeando los siguientes puntos:'}</p>
    <table cellpadding="0" cellspacing="0" style="margin-left:10px; border: 1px solid;">
		<tr>
        	<td style="border: 1px solid;"><strong>{l s='Revisión de niveles:'}</strong></td>
        <tr>
        	<td style="border: 1px solid;">{l s='Líquido limpiaparabrisas '}</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">{l s='Líquido refrigerante'}</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">{l s='Líquido de dirección asistida'}</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">&nbsp;</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;"><strong>{l s='Ajuste de la presión de los neumáticos'}</strong></td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">&nbsp;</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;"><strong>{l s='Revisión del estado de:'}</strong></td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">{l s='Neumáticos: grado de desgaste y deformación'}</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">{l s='Frenos: estado de discos y pastillas'}</td>
        </tr>
        <tr>
        	<td style="border: 1px solid;">{l s='Escobillas (limpiaparabrisas)'}</td>
        </tr>                
        <tr>
        	<td style="border: 1px solid;">{l s='Tubo  de escape'}</td>
        </tr>                
        <tr>
        	<td style="border: 1px solid;">{l s='Luces exteriores'}</td>
        </tr>                
        <tr>
        	<td style="border: 1px solid;">{l s='Transmisión, amortiguadores y rodamientos'}</td>
        </tr>                
        <tr>
        	<td style="border: 1px solid;">{l s='Sistema de aire acondicionado'}</td>
        </tr>                                                
    </table>
    <p>&nbsp;</p>
    <p>{l s='El responsable del taller informará al cliente del resultado de esta revisión indicándole, si procede, las operaciones recomendadas para un correcto mantenimiento del vehículo, así como su coste en mano de obra y material o productos necesarios, sin que esto suponga ningún compromiso para el cliente. '}</p>
{strip}
{addJsDef map=''}
{addJsDef markers=array()}
{addJsDef infoWindow=''}
{addJsDef locationSelect=''}
{addJsDef defaultLat=$defaultLat}
{addJsDef defaultLong=$defaultLong}
{addJsDef hasStoreIcon=$hasStoreIcon}
{addJsDef distance_unit=$distance_unit}
{addJsDef img_store_dir=$img_store_dir}
{addJsDef img_ps_dir=$img_ps_dir}
{addJsDef searchUrl=$searchUrl}
{addJsDef logo_store=$logo_store}
{addJsDefL name=translation_1}{l s='No stores were found. Please try selecting a wider radius.' js=1}{/addJsDefL}
{addJsDefL name=translation_2}{l s='store found -- see details:' js=1}{/addJsDefL}
{addJsDefL name=translation_3}{l s='stores found -- view all results:' js=1}{/addJsDefL}
{addJsDefL name=translation_4}{l s='Phone:' js=1}{/addJsDefL}
{addJsDefL name=translation_5}{l s='Get directions' js=1}{/addJsDefL}
{addJsDefL name=translation_6}{l s='Not found' js=1}{/addJsDefL}
{/strip}
{/if}
