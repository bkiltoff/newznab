
<h1>Search</h1>

<form method="get" action="{$smarty.const.WWW_TOP}/search">
	<div style="text-align:center;">
		<label for="search" style="display:none;">Search</label>
		<input id="search" name="search" value="{$search|escape:'html'}" type="text"/>
		<input id="search_search_button" type="submit" value="search" />
		{if $header_menu_cat}<input type="hidden" name="t" value="{$header_menu_cat}" />{/if}
	</div>
</form>


{if $results|@count > 0}

<form id="nzb_multi_operations_form" method="get" action="{$smarty.const.WWW_TOP}/search">

<br/>
<div class="nzb_multi_operations">
	<small>With Selected:</small>
	<input type="button" class="nzb_multi_operations_download" value="Download NZBs" />
	<input type="button" class="nzb_multi_operations_cart" value="Add to Cart" />
	<input type="button" class="nzb_multi_operations_sab" value="Send to SAB" />
</div>
<br/><br/>


<table style="width:100%;" class="data highlight icons">
	<tr>
		<th><input type="checkbox" class="nzb_check_all" /></th>
		<th>name<br/><a title="Sort Descending" href="{$orderbyname_desc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_down.gif" alt="" /></a><a title="Sort Ascending" href="{$orderbyname_asc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_up.gif" alt="" /></a></th>
		<th>category<br/><a title="Sort Descending" href="{$orderbycat_desc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_down.gif" alt="" /></a><a title="Sort Ascending" href="{$orderbycat_asc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_up.gif" alt="" /></a></th>
		<th>posted<br/><a title="Sort Descending" href="{$orderbyposted_desc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_down.gif" alt="" /></a><a title="Sort Ascending" href="{$orderbyposted_asc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_up.gif" alt="" /></a></th>
		<th>size<br/><a title="Sort Descending" href="{$orderbysize_desc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_down.gif" alt="" /></a><a title="Sort Ascending" href="{$orderbysize_asc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_up.gif" alt="" /></a></th>
		<th>files<br/><a title="Sort Descending" href="{$orderbyfiles_desc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_down.gif" alt="" /></a><a title="Sort Ascending" href="{$orderbyfiles_asc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_up.gif" alt="" /></a></th>
		<th>stats<br/><a title="Sort Descending" href="{$orderbystats_desc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_down.gif" alt="" /></a><a title="Sort Ascending" href="{$orderbystats_asc}"><img src="{$smarty.const.WWW_TOP}/views/images/sorting/arrow_up.gif" alt="" /></a></th>
		<th></th>
	</tr>

	{foreach from=$results item=result}
		<tr class="{cycle values=",alt"}" id="guid{$result.guid}">
			<td><input type="checkbox" class="nzb_check" name="id[]" value="{$result.guid}" /></td>
			<td>
				<a class="title" title="View details" href="{$smarty.const.WWW_TOP}/details/{$result.searchname|escape:"htmlall"}/viewnzb/{$result.guid}">{$result.searchname|escape:"htmlall"|replace:".":" "}</a>
				<div class="resextra">
					{if $result.nfoID > 0}<a href="{$smarty.const.WWW_TOP}/nfo/{$result.guid}" title="View Nfo" class="modal_nfo" rel="nfo">[Nfo]</a>{/if}
					{if $result.imdbID > 0}<a target="_blank" href="{$site->dereferrer_link}http://www.imdb.com/title/tt{$result.imdbID}/" name="name{$result.imdbID}" title="View movie info" class="modal_imdb" rel="movie" >[Cover]</a>{/if}
					{if $result.rageID > 0}<a href="{$smarty.const.WWW_TOP}/series/{$result.rageID}" title="View all episodes">[View Series]</a>{/if}
					{if $result.tvairdate != ""}<span title="{$result.tvtitle} Aired on {$result.tvairdate|date_format}">[Aired {if $result.tvairdate|strtotime > $smarty.now}in future{else}{$result.tvairdate|daysago}{/if}]</span>{/if}

					{if $isadmin}
						<a href="{$smarty.const.WWW_TOP}/admin/release-edit.php?id={$result.ID}&amp;from={$smarty.server.REQUEST_URI|escape:"url"}" title="Edit Release">[Edit</a> <a onclick="return confirm('Are you sure?');" href="{$smarty.const.WWW_TOP}/admin/release-delete.php?id={$result.ID}&amp;from={$smarty.server.REQUEST_URI|escape:"url"}" title="Delete Release">Del</a> <a onclick="return confirm('Are you sure?');" href="{$smarty.const.WWW_TOP}/admin/release-rebuild.php?id={$result.ID}&amp;from={$smarty.server.REQUEST_URI|escape:"url"}" title="Rebuild Release - Delete and reset for reprocessing if binaries still exist.">Reb]</a>
					{/if}
				</div>
			</td>
			<td class="less"><a title="Browse {$result.category_name}" href="{$smarty.const.WWW_TOP}/browse?t={$result.categoryID}">{$result.category_name}</a></td>
			<td class="less mid" title="{$result.postdate}">{$result.postdate|timeago}</td>
			<td class="less right" width="55">{$result.size|fsize_format:"MB"}</td>
			<td class="less mid"><a title="View file list" href="{$smarty.const.WWW_TOP}/filelist/{$result.guid}">{$result.totalpart}</a></td>
			<td class="less" nowrap="nowrap"><a title="View comments for {$result.searchname|escape:"htmlall"}" href="{$smarty.const.WWW_TOP}/details/{$result.searchname|escape:"htmlall"}/viewnzb/{$result.guid}#comments">{$result.comments} cmt{if $result.comments != 1}s{/if}</a><br/>{$result.grabs} grab{if $result.grabs != 1}s{/if}</td>
			<td class="icons">
				<div class="icon icon_nzb"><a title="Download Nzb" href="{$smarty.const.WWW_TOP}/download/{$result.searchname|escape:"htmlall"}/nzb/{$result.guid}">&nbsp;</a></div>
				<div class="icon icon_cart" title="Add to Cart"></div>
				<div class="icon icon_sab" title="Send to my Sabnzbd"></div>
			</td>
		</tr>
	{/foreach}
	
</table>
<br/>

<div class="nzb_multi_operations">
	<small>With Selected:</small>
	<input type="button" class="nzb_multi_operations_download" value="Download NZBs" />
	<input type="button" class="nzb_multi_operations_cart" value="Add to Cart" />
	<input type="button" class="nzb_multi_operations_sab" value="Send to SAB" />
</div>

<br/><br/><br/>

</form>

{/if}
