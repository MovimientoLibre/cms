<?php
# ***** BEGIN LICENSE BLOCK *****
# This file is part of DotClear.
# Copyright (c) 2004 Olivier Meunier and contributors. All rights
# reserved.
#
# DotClear is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# DotClear is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with DotClear; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
# ***** END LICENSE BLOCK *****
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php dcInfo('lang'); ?>"
lang="<?php dcInfo('lang'); ?>">
<head>
	<meta http-equiv="Content-Type"
	content="text/html; charset=<?php dcInfo('encoding'); ?>" />
	<meta name="MSSmartTagsPreventParsing" content="TRUE" />
	<?php dcHeadLinks(); ?>
	<link rel="alternate" type="application/rss+xml" title="RSS" href="<?php dcInfo('rss'); ?>" />
	<link rel="alternate" type="application/atom+xml" title="Atom" href="<?php dcInfo('atom'); ?>" />
	<meta name="DC.title" content="<?php dcInfo(); ?>" />
	<title><?php dcSinglePostTitle('%s - '); dcSingleCatTitle('%s - ');
	dcSingleMonthTitle('%s - '); dcCustomTitle('%s - '); dcInfo(); ?></title>
	
	<link rel="stylesheet" type="text/css" href="../../../../core/print.css" media="print" />
	<link rel="stylesheet" type="text/css" href="../../skins/default/all.css" media="screen" />
	<?php dcPostTrackbackAutoDiscovery(); ?>
</head>

<body>

<div id="page">

<div id="header">
	<div class="wrapper">
		<h1><a href="<?php dcInfo('url'); ?>"><?php dcInfo(); ?></a></h1>
	</div>
</div>

<div id="prelude" class="accessibility">
	<ul>
		<li><a href="#main">Aller au contenu</a></li>
		<li><a href="#nav-sec">Aller au menu</a></li>
		<li><a href="#search">Aller &agrave; la recherche</a></li>
	</ul>
</div>

<div id="content">
	<div id="content_wrapper">
		<div id="main" class="content">
			<div class="wrapper">
				<?php if ($err_msg != '') : /* Si on a une quelconque erreur, on l'affiche */?>
					<div class="error"><strong>Erreur : </strong>
					<?php echo $err_msg; ?></div>
				
				<?php elseif ($preview) : /* Si on demande la prévisualisation d'un commentaire */?>
					<h3>Commentaire pour <?php dcPostTitle(); ?></h3>
					<div id="comment-preview">
						<blockquote>
						<?php dcCommentPreview(); ?>
						</blockquote>
					</div>
					
					<h3>Changer le commentaire</h3>
					<?php include dirname(__FILE__).'/form.php'; ?>
					
				<?php elseif ($mode != 'post') : /* Si aucune erreur et mode != post on affiche une liste de billets */?>
					<?php # Phrase affiché en cas de recherche (%s est le mot cherché)
					dcSearchString('<p>R&eacute;sultats de votre recherche de <em>%s</em>.</p>');
					?>
					
					<?php include dirname(__FILE__).'/list.php'; ?>
					
				<?php else : /* Sinon, mode = post, donc billet unique (avec commentaires et tout le reste)*/?>
					<?php include dirname(__FILE__).'/post.php'; ?>
				<?php endif; ?>
			</div>
		</div>
		<div id="sub" class="content">
			<div class="wrapper">
				<?php /* Affichage du blog "selection uniquement si des billets sont présents */ ?>
				<?php dcSelection('<div id="selection"><h2>&Agrave; retenir</h2><ul>%s</ul></div>'); ?>
				
				<div id="links">
					<h2>Liens</h2>
					<?php dcBlogroll::linkList(); ?>
				</div>
			</div>
		</div>
		<div id="nav-sec" class="nav">
			<div class="wrapper">
				<div id="calendar">
					<h2>Calendrier</h2>
					<?php #Affichage du calendrier
					dcCalendar('<table summary="Calendrier">%s</table>'); ?>
				</div>
				
				<div id="search">
					<form action="<?php dcInfo('search'); ?>" method="get">
					
						<h2><label for="q">Rechercher</label></h2>
						<p class="field"><input name="q" id="q" type="text" size="10"
						value="<?php dcSearchString(); ?>" accesskey="4" />
						<input type="submit" class="submit" value="ok" /></p>
					
					</form>
				</div>
				
				<div id="categories">
					<h2>Cat&eacute;gories</h2>
					<?php dcCatList(); ?>
				</div>
				
				<div id="archives">
					<h2>Archives</h2>
					<?php dcMonthsList(); ?>
				</div>
				
				<div id="syndicate">
				<h2>Syndication</h2>
				<ul>
					<li><a href="<?php dcInfo('rss'); ?>">fil rss</a></li>
					<li><a href="<?php dcInfo('rss'); ?>?type=co">fil rss commentaires</a></li>
					<li><a href="<?php dcInfo('atom'); ?>">fil atom</a></li>
					<li><a href="<?php dcInfo('atom'); ?>?type=co">fil atom commentaires</a></li>
				</ul>
				</div>
			</div>
		</div>
	</div>
	<div id="nav-pri" class="nav">
		<div class="wrapper"></div>
	</div>
	<div id="nav-lang" class="nav">
		<div class="wrapper">
			<?php dcLangList('<ul>%s</ul>'); ?>
		</div>
	</div>
	<div id="extradiv1" class="extradiv"></div>
	<div id="extradiv2" class="extradiv"></div>
</div>

<div id="footer">
	<div class="wrapper">
		<p><a href="http://www.dotclear.net/">propuls&eacute; par DotClear</a></p>
	</div>
</div>

</div>

</body>
</html>
