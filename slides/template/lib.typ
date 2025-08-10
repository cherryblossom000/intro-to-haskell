#import "@preview/touying:0.6.1": config-colors, config-common, config-page, touying-slide, touying-slide-wrapper, touying-slides, config-store, utils

#let x-margin = 40pt
#let top-margin = 120pt
#let bottom-margin = 40pt

#let title-slide(..args) = touying-slide-wrapper(self => {
	let info = self.info + args.named()
	touying-slide(
		self: self,
		[
			#place(top + left, dx: -x-margin, dy: -top-margin, image("img/bg-1.png", width: 100%))
			#place(bottom + right, dx: x-margin, dy: bottom-margin, image("img/bg-2.png", width: 100%))

			#set align(center + horizon)
			#image("img/mac-logo-text.png", width: 25%)
			#v(-1em)
			#text(2em, strong(info.title)) \

			#text(.75em, weight: "light", tracking: 3pt, upper(info.subtitle))
			#v(1em)
			#text(.75em, info.author)
		]
	)
})

#let slide(title: auto, ..args) = touying-slide-wrapper(self => {
	if title != auto {
		self.store.title = title
	}

	let header(self) = {
		box(
			inset: (x: x-margin, bottom: 15pt),
			underline(
				stroke: 4pt + self.colors.primary,
				offset: 20pt,
				text(self.colors.primary, strong(
					if self.store.title != none {
						utils.call-or-display(self, self.store.title)
					} else {
						utils.display-current-heading(level: 2)
					}
				))
			)
		)
	}

	let footer(self) = {
		// place(right, image("img/mac-logo.png", height: 50pt))
		place(right, box(inset: (right: 0.6em), text(0.6em, context utils.slide-counter.display() + " / " + utils.last-slide-number)))
	}

	self = utils.merge-dicts(
		self,
		config-page(header: header, footer: footer)
	)

	touying-slide(self: self, ..args)
})

#let mac-theme(aspect-ratio: "16-9", ..args, body) = {
	set text(font: "Poppins Latin", size: 25pt)
	set strong(delta: -100)
	show heading: it => if it.level == 3 { text(weight: "semibold", it) } else { it }
	show raw: set text(font: "FiraCode Nerd Font")

	show: touying-slides.with(
		config-page(paper: "presentation-" + aspect-ratio, margin: (x: x-margin, top: top-margin, bottom: bottom-margin)),
		config-common(slide-fn: slide),
		config-colors(primary: rgb("#5757d3")),
		config-store(title: none),
		..args,
	)

	body
}
