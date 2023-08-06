import { getCollection } from "astro:content";

export async function get({ params }) {
  const collection = await getCollection('drafts')
  const res = collection.find(x => x.slug == params.slug)

  const panfluteFilters = ['convert_lists.py','uppercase_headers.py']
  const panflutePath = ['$HOME/Desktop/about_blank/filters']

  res.data['panflute-filters'] = panfluteFilters
  res.data['panflute-path'] = panflutePath

  // res.data.panflute-filters? = collections

}