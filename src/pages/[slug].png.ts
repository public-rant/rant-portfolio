import { faker } from '@faker-js/faker'

let imageUrl = import.meta.env.DRAFTS == 'true' ? faker.image.urlLoremFlickr({width: 100, height: 50, category: 'nature'}) : null

// FIXME
// imageUrl ||= factory(draft)
// export async function ImageFactory(draft: string) {
	// const chatCompletion = await openai.generateImage({
	// 	model: "dalle",
	// 	max_tokens: 20,
	// 	messages: [{role: 'user', content: content}],
	// });

	// return chatCompletion
// }


export async function get() {
    if (imageUrl) {
        const response = await fetch(imageUrl)
        const buffer = Buffer.from(await response.arrayBuffer());

        return new Response(buffer, { status: 200 })
    }
};
