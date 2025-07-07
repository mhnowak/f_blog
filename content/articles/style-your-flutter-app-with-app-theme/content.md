## What exactly is the AppTheme?

Theme data is a field you can add to your `MaterialApp` to specify default values for the colors, fonts, shapes, etc. You can also access it through `Theme.of(context)`. Material widgets are styled by default by the theme, so it's a great place to put your styling code.

## Great, why doesn't everyone use it?

Well, it's huge and it's very easy to get lost here. Especially when you're at the beginning of your project, it's really hard to visualize how specifying different colors, shapes, etc., is going to affect it. I'm not going to go through all of the fields. I'd rather try to give you an idea of how it works and how you could start using it.

To clarify, AppTheme doesn't need to replace our current theming strategy as it's very different from the theming that designers use. It's more development-oriented as it styles widgets, so you might consider specifying colors, etc., you get from designs in different places and just referencing it there.

## The idea

Instead of styling directly within the widget tree or splitting everything into different classes, you can add the style directly to the theme and use base/default widgets when writing code.

## Why?

First of all, it's just easier to read because it's less code. Having multiple classes also requires you to remember each of them, but it's not as easy as it sounds in large projects. I've often run into the problem that I've created a widget that I've already had but just named it differently.

Since it's less code, it's also faster to write code itself, right? Instead of styling everything on the go, some of the stuff will already be styled by default. All you need to do is write a skeleton for the view. Yes, it's a little optimistic and not applicable in many cases, but it's hard to cover all of the scenarios.

Also, it's possible to add different themes for light/dark modes as MaterialApp uses a separate field for `darkTheme`.

Maintaining the project becomes easier, e.g., when we're about to swap colors in some places, we could swap them just within a theme and the rest should be updated itself.

## AppBar example

Instead of styling in widget tree like this:

<script src="https://gist.github.com/mhnowak/b5022fc58348a4b5d358a79acc8fc2fd.js"></script>

Theming logic can be moved to ThemeData:

<script src="https://gist.github.com/mhnowak/8b02a57e57f8e753707744c3e6e70aaa.js"></script>

> `headline6` is used as it's default style for app bar's title.

AppBar:

<script src="https://gist.github.com/mhnowak/457ef20e04bac03d2c5aade52a10197a.js"></script>

It's a simple example, but you can do much more like button, input, sliders, themes, and many more. That's why I suggest you look at them when working on UI rather than learning about the theme itself, as it can be overwhelming.
