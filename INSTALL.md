## Installing OIIO

Download the source code from:
https://sites.google.com/site/openimageio/home

Let's assume the zip package was downloaded and unpacked to <code>$OIIO_ROOT/</code>.

In the project directory, run <code>make</code>. This will generate the directory <code>dist/&lt;os&gt;/</code>, where 
(os can will depends on your operating system) under 
the root source directory <code>$OIIO_ROOT/</code>.

First thing we need to do is to set the <code>OPENIMAGEIOHOME</code> environment variable:

<code>export OPENIMAGEIOHOME="/$OIIO_ROOT/dist/&lt;os&gt;/"</code>

## Installing OSL

Download the source code from:
https://github.com/imageworks/OpenShadingLanguage/

Let's assume the zip package was downloaded and unpacked to <code>$OSL_ROOT/</code>.

In the project directory, run <code>make</code>. This will generate the directory <code>dist/&lt;os&gt;/</code>, where 
(os can will depends on your operating system) under 
the root source directory <code>$OSL_ROOT/</code>.

First thing we need to do is to set the <code>OSLHOME</code> environment variable:

<code>export OSLHOME="/$OSL_ROOT/dist/&lt;os&gt;/"</code>

## Building rt-osl

Download the source code. Let's assume the zip package was downloaded and unpacked to <code>$RT_OSL_ROOT/</code>.

Create a directory at the root directory named <code>build</code> and run

<code>cmake ../src</code>
