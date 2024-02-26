import { Inter } from 'next/font/google';
import { useAccount, useBalance, useDisconnect } from 'wagmi';

import { ConnectButton } from '@rainbow-me/rainbowkit';
import { FormattedTransactionReceipt, formatEther } from 'viem';

const inter = Inter({ subsets: ['latin'] });

export default function Home() {

	const { isConnected, isConnecting, address } = useAccount()
	const balance = useBalance({ address: address, })
	const { disconnect } = useDisconnect()
	console.log(balance)

	if (isConnecting) return <p>Loading....</p>


	if (!isConnected) return (
		<div><p>please connect wallet</p> <ConnectButton /></div>
	)
	return (
		<main className={`flex min-h-screen flex-col items-center justify-between p-24 ${inter.className}`}>
			<p>{address}</p>

			{balance.data && <p>Balance :{formatEther(balance.data.value)}</p>}

			<button onClick={() => { disconnect() }} className='p-4 bg-blue-400 text-white rounded-md'>
				discount wallet
			</button>


		</main>
	);
}
