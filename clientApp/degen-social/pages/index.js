import Head from 'next/head'
import Image from 'next/image'
import styles from '../styles/Home.module.css'
import posts from '../data/posts.json'
import { useWeb3 } from "@3rdweb/hooks" 

export default function Home() {
  
  const { connectWallet, address, error } = useWeb3();
  
  const post_list = posts.map(post => ({
    // return an object with params.color set to the color's name
    params: { post: post.name,
              post: post.content }
  }))


  
  return (
    <div className={styles.container}>
      <Head>
        <title>Create Next App</title>
        <meta name="description" content="Generated by create next app" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>
          Degen Social
        </h1>

        <p className={styles.description}>
          The social media platform for sharing and benefitting from your alpha
        </p>

        <button className="px-4 py-2 rounded-md bg-purple-600 cursor-pointer hover:bg-purple-500 text-xl font-semibold duration-100 text-white"
          onClick={()=>connectWallet("injected")}
        >
          Connect Wallet
        </button>

        <div className={styles.card}>
        {posts.map(post => (
          <h2>{post.name}: {post.content}</h2>
        ))}
        </div>

        <form action="http://www.acme.com/register" method="POST">
        <label for="post">Post your alpha here:</label>
        <input id="post" type="text" autocomplete="name" required />
        <button type="submit">Post</button>
        </form>

        <div className={styles.grid}>
          <a href="https://nextjs.org/docs" className={styles.card}>
            <h2>Documentation &rarr;</h2>
            <p>Find in-depth information about Next.js features and API.</p>
          </a>

          <a href="https://nextjs.org/learn" className={styles.card}>
            <h2>Learn &rarr;</h2>
            <p>Learn about Next.js in an interactive course with quizzes!</p>
          </a>
          <a
            href="https://github.com/vercel/next.js/tree/canary/examples"
            className={styles.card}
          >
            <h2>Examples &rarr;</h2>
            <p>Discover and deploy boilerplate example Next.js projects.</p>
          </a>

          <a
            href="https://vercel.com/new?utm_source=create-next-app&utm_medium=default-template&utm_campaign=create-next-app"
            className={styles.card}
          >
            <h2>Deploy &rarr;</h2>
            <p>
              Instantly deploy your Next.js site to a public URL with Vercel.
            </p>
          </a>
        </div>
      </main>

      <footer className={styles.footer}>
        <a
          href="https://vercel.com?utm_source=create-next-app&utm_medium=default-template&utm_campaign=create-next-app"
          target="_blank"
          rel="noopener noreferrer"
        >
          Powered by{' '}
          <span className={styles.logo}>
            <Image src="/vercel.svg" alt="Vercel Logo" width={72} height={16} />
          </span>
        </a>
      </footer>
    </div>
  )
}
