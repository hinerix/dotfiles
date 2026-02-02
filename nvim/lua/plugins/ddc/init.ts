import { BaseConfig, ConfigArguments } from "jsr:@shougo/ddc-vim/config";

export class Config extends BaseConfig {
	override config(args: ConfigArguments): Promise<void> {

		const sources = [
			"around",
			"buffer",
      "skkeleton",
      "skkeleton_okuri",
		];

		args.contextBuilder.patchGlobal({
			ui: "native",
			autoCompleteEvents: [
				"InsertEnter",
				"CmdlineEnter",
				"CmdlineChanged",
				"TextChangedI",
				"TextChangedP",
				"TextChangedT",
			],
			sources: sources,
			sourceOptions: {
				_: {
					ignoreCase: true,
					matchers: [ "matcher_fuzzy" ],
					sorters: [ "sorter_fuzzy" ],
					converters: [ "converter_fuzzy" ],
					timeout: 1000,
				},
				around: { mark: "around" },
				buffer: { mark: "buffer" },
				input: {
					mark: "input",
					forceCompletionPattern: String.raw`\S/\S*`,
					isVolatile: true,
					sorters: [ "sorter_fuzzy" ],
				},
				skkeleton: {
					mark: "skk",
					matchers: [],
					sorters: [],
					isVolatile: true,
					minAutoCompleteLength: 2,
				},
				skkeleton_okuri: {
					mark: "skk*",
					matchers: [],
					sorters: [],
					isVolatile: true,
					minAutoCompleteLength: 2,
				},
			},
			sourceParams: {
				around: { maxSize: 500 },
				buffer: {
					requireSameFiletype: false,
					limitBytes: 50000,
					fromAltBuf: true,
					forceCollect: true,
				},
			},
		});
		return Promise.resolve();
	}
}
